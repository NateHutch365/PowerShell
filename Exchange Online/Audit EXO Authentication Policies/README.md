# Exchange Online Authentication Policy Auditor

This PowerShell script is designed for Exchange Online administrators to audit and report on user authentication policies within their organization. It specifically targets users within specified domain(s) and exports the findings to a CSV file for further analysis.

## Features

- **List All Authentication Policies:** Displays all existing authentication policies in the organization in yellow text.
- **Highlight Default Authentication Policy:** Shows the default authentication policy in red text. If no custom default policy is set, it warns that some basic authentication protocols may be enabled and suggests creating and setting a custom policy as default.
- **Domain-Specific User Audit:** Allows administrators to specify one or more domains to search for within user principal names (UPNs). It then retrieves and reports on the authentication policy assigned to each user in those domains.
- **CSV Export:** Compiles the audit results into a CSV file for easy viewing and further analysis.

## How to Use

1. **Prepare the Script:**
   - Edit the `$domains` array within the script to include the domain(s) you wish to audit. For example, `@("domain1.com", "domain2.com")`.

2. **Set the CSV Export Path:**
   - Change the `$csvPath` variable to the desired output location of the CSV report. For instance, `"C:\Path\To\Output\AuthenticationPoliciesReport.csv"`.

3. **Run the Script:**
   - Execute the script in a PowerShell session connected to Exchange Online. Ensure you have the necessary permissions to retrieve user and authentication policy information.

4. **Review the Results:**
   - Once the script completes, open the generated CSV file at the specified path to review the authentication policy assignments.

## Prerequisites

- PowerShell connected to Exchange Online
- Permissions to view authentication policies and user objects in Exchange Online
- Knowledge of the domain(s) you want to audit within your organization

## Note

This script is intended for Exchange Online administrative use. Always test scripts in a non-production environment before applying them to your live environment to ensure compatibility and avoid unintended effects.

If the policy that returns is 'None' then the account doesn't have an authentication policy assigned and Exchange uses the default policy for the organization (the one managed through the Microsoft 365 admin center). Recommendation is to create a custom policy which will block all protocols by default and assign this to your users, ideally as the new default authentication policy.
