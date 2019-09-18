# Azure DevOps Release Extension: Create Event Grid Subscription

This repository contains a VSTS/Azure DevOps extension that can be used
to create Azure Event Grid Subscriptions.

It can be installed in Azure DevOps from the [Marketplace](https://marketplace.visualstudio.com/items?itemName=RasmusWatjen.EventGridSubscriptionExtension).

## Developing VSTS tasks

If you are looking to create your own VSTS / Azure DevOps extension, you 
might find these links useful:

* https://docs.microsoft.com/en-us/rest/api/vsts/serviceendpoint/types/list?view=vsts-rest-4.1#examples
* https://github.com/Microsoft/vsts-task-lib/blob/9cedd04cc64c6b899b8b7826c54ec67c4682aa28/powershell/Docs/Commands.md
* https://github.com/Microsoft/vsts-rm-extensions/blob/master/docs/authoring/endpoints/dataSources.md#parameters
* https://github.com/Microsoft/vsts-tasks
* https://docs.microsoft.com/en-us/azure/devops/extend/develop/add-build-task?view=vsts

To create an extension using the code in the src folder, run this command
`tfx extension create --manifest-globs vss-extension.json`

## TODO

* Event grid topic list is not loading in settings ui
* git push to github
* storage account list is not loading in settings ui
