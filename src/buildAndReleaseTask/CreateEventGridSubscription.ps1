[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Import-Module Az.EventGrid

$resourceGroupName = Get-VstsInput -Name "ResourceGroupName" -Require
$connectedServiceNameARM = Get-VstsInput -Name "ConnectedServiceNameARM" -Require
$endPointRM = Get-VstsEndpoint -Name $connectedServiceNameARM -Require
$subscriptionId = $endpointRM.Data.subscriptionId

$eventGridTopicName = Get-VstsInput -Name "eventGridTopicName" -Require
$eventSubscriptionName = Get-VstsInput -Name "eventSubscriptionName" -Require
$endpointUrl = Get-VstsInput -Name "endpointUrl" -Require

$deadLetterEvents = Get-VstsInput -Name "deadLetterEvents" -AsBool -Default $true
$deadLetterStorageAccountName = Get-VstsInput -Name "deadLetterStorageAccountName" -Default $null
$deadLetterBlobContainerName = Get-VstsInput -Name "deadLetterBlobContainerName" -Default $null

$eventTtl = Get-VstsInput -Name "eventTtl" -AsInt -Default 240
$maxDeliveryAttempt = Get-VstsInput -Name "maxDeliveryAttempt" -AsInt -Default 10
$includedEventType = Get-VstsInput -Name "includedEventType" -Default $null

if ($deadLetterEvents) {
    if (!$deadLetterStorageAccountName -or !$deadLetterBlobContainerName) {
        Throw "When deadlettering of events is enabled, you must also specify deadletter storage account and blob container name"
    }
    $deadletterResourceId = "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Storage/storageAccounts/$deadLetterStorageAccountName/blobServices/default/containers/$deadLetterBlobContainerName"
}

$params = @()
$params += "-ResourceGroupName $resourceGroupname"
$params += "-TopicName $eventGridTopicName"
$params += "-EventSubscriptionname $eventSubscriptionname"
$params += "-Endpoint $endpointUrl"
$params += "-EndpointType webhook"
if ($eventTtl) {
    $params += "-EventTtl $eventTtl"
}
if ($maxDeliveryAttempt) {
    $params += "-MaxDeliveryAttempt $maxDeliveryAttempt"
}
if ($includedEventType) {
    $params += "-IncludedEventType $includedEventType"
}
if ($deadLetterEvents) {
    $params += "-DeadLettterEndpoint $deadletterResourceId"
}


$cmd = "New-AzEventGridSubscription $params"
Invoke-Expression $cmd
