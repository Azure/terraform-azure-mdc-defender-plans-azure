package upgrade

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/logger"
	teststructure "github.com/gruntwork-io/terratest/modules/test-structure"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExampleUpgrade_basic(t *testing.T) {
	currentRoot, err := test_helper.GetCurrentModuleRootPath()
	if err != nil {
		t.FailNow()
	}
	currentMajorVersion, err := test_helper.GetCurrentMajorVersionFromEnv()
	if err != nil {
		t.FailNow()
	}
	examplePath := "examples/single_subscription"
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
		"VirtualMachines",
	}
	vars := map[string]interface{}{
		"mdc_plans_list": plans,
	}
	cleanAllExistingPlans(t, "../../", examplePath, plans, vars)
	test_helper.ModuleUpgradeTest(t, "Azure", "terraform-azure-mdc-defender-plans-azure", examplePath, currentRoot, terraform.Options{
		Upgrade: true,
	}, currentMajorVersion)
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
