package e2e

import (
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamples_single_subscription(t *testing.T) {
	plans := []string{
		"AppServices",
		"Arm",
		"CloudPosture",
		"Containers",
		"Dns",
		"KeyVaults",
		"OpenSourceRelationalDatabases",
		"SqlServers",
		"SqlServerVirtualMachines",
		"CosmosDbs",
		"StorageAccounts",
		"VirtualMachines",
	}
	test_helper.RunE2ETest(t, "../../", "examples/single_subscription", terraform.Options{
		Upgrade: true,
		Vars: map[string]interface{}{
			"mdc_plans_list": plans,
		},
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		pricingIds := output["subscription_pricing_id"].(map[string]any)
		for _, p := range plans {
			assert.Contains(t, pricingIds, p)
			assert.Regexp(t, "/subscriptions/.+/providers/Microsoft.Security/pricings/.+", pricingIds[p])
		}
	})
}
