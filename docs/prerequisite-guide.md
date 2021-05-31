# Doing the Prerequisites

Before getting started, a few things must be setup manually or by some other process. This guide offers a path from scratch.

## Step 1: Create a Subscription

Visit the [subscription blade page][subscription_blade] on the azure portal.

_If the only subscription is the Free Trial, then follow the process to upgrade to pay-as-you-go before moving forward._

Click the "Add" button to create a new tenant. Check the agreement box and select "Pay-as-you-go".

After successful sign-up, and redirect to azure. View the subscription on the [subscription page][subscription_blade]. _Update the filter to display all available subscriptions._

Select the name and rename the subscription to something more meaningful e.g. "Demo AKS". 

Open the Cloud Shell in Azure Portal:

```shell
az account set -s "Demo AKS" # set this as the primary account
```

## Step 2: Create an AD Tenant

Visit the AD Page and click "Switch Tenant".

Follow the prompts to create an Active Directory Tenant for your domain. 

Then [follow the guide][add_ad_to_sub_guide] to ensure the new AD is associated with the subscription.

## Step 3: Add an AD application for terraform

From the AD tenant page, find the App Registrations. Onboard an new application called Terraform. 

## Step 4: Create the client id and client secret

From the "Terraform" AD Application page, select "Certificates & secrets". Create a new client secret. Save the client id, client secret, and tenent id.

__Save the output server principal credentials to a safe place.__

## Step 5: Add Directory-level role binding to service principal

Visit the AD Page and select "Roles and administrators". Find "Global administrator". Search for members "Terraform" and add the binding.

[subscription_blade]: https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade
[add_ad_to_sub_guide]: https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory?amp;clcid=0x9 

