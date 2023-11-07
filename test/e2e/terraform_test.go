package e2e

import (
	"fmt"
	"os"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	teststructure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestExamples_single_subscription(t *testing.T) {
	plans := []string{
		"AppServices",
		"Arm",
		"Containers",
		"KeyVaults",
		"OpenSourceRelationalDatabases",
		"SqlServers",
		"SqlServerVirtualMachines",
		"CosmosDbs",
		"StorageAccounts",
		"Api",
	}
	vars := map[string]interface{}{
		"mdc_plans_list": plans,
	}

	moduleRoot := "../../"
	examplePath := "examples/single_subscription"

	cleanAllExistingPlans(t, moduleRoot, examplePath, plans, vars)

	test_helper.RunE2ETest(t, moduleRoot, examplePath, terraform.Options{
		Upgrade: true,
		Vars:    vars,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		pricingIds := output["subscription_pricing_id"].(map[string]any)
		for _, p := range plans {
			assert.Contains(t, pricingIds, p)
			assert.Regexp(t, "/subscriptions/.+/providers/Microsoft.Security/pricings/.+", pricingIds[p])
		}
	})
}

func cleanAllExistingPlans(t *testing.T, moduleRoot string, examplePath string, plans []string, vars map[string]interface{}) {
	subId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if subId == "" {
		t.Skip("you need environment variable `ARM_SUBSCRIPTION_ID` to run this test.")
	}
	tmpFolder := teststructure.CopyTerraformFolderToTemp(t, moduleRoot, examplePath)
	defer func() {
		_ = os.RemoveAll(tmpFolder)
	}()
	opt := &terraform.Options{
		TerraformDir: tmpFolder,
		Vars:         vars,
		NoColor:      true,
		NoStderr:     true,
		Logger:       logger.Default,
	}
	terraform.Init(t, opt)
	for _, p := range plans {
		command := terraform.RunTerraformCommand(t, opt, "import", fmt.Sprintf(`module.mdc_plans_enable.azurerm_security_center_subscription_pricing.asc_plans["%s"]`, p), fmt.Sprintf(`/subscriptions/%s/providers/Microsoft.Security/pricings/%s`, subId, p))
		println(command)
	}
	terraform.Destroy(t, opt)
}
