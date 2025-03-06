# AC-109 LAMBDA
[[AWS]]

  https://confluence.mixtelematics.com/display/CT/Deploy+or+Update+a+Lambda

  1 Add lambda to our project
  2 Add pipeline to build artifact eg:
    https://mixtelematics.visualstudio.com/DeviceIntegration/_apps/hub/ms.vss-ciworkflow.build-ci-hub?_a=edit-build-definition&id=795
    The above pipeline also uploads the artifact to the s3 bucket:
    https://s3.console.aws.amazon.com/s3/buckets/int-di-s3artifacts?region=eu-west-1&tab=objects
  4 Add lambda to CDK and Push changes.
  5 Run pipeline MiX CDK 9001 for our branch, something like this:
    https://mixtelematics.visualstudio.com/Common/_build/results?buildId=148851&view=logs&j=275f1d19-1bd8-5591-b06b-07d489ea915a&t=78db2542-c627-4140-8a7a-d06178fff4e4
  6 Release pipeline for our stuff: (Trigger the DI Lambda (INT).)
    https://mixtelematics.visualstudio.com/Common/_release?_a=releases&view=mine&definitionId=94

    https://dev.azure.com/MiXTelematics/Common/_releaseProgress?_a=release-environment-logs&releaseId=29816&environmentId=149544



	CAN | Local 

	MiX.DI.DynamicCAN.DynamoDB.PopulateCANDB

	Config/MR/Feature/AC-109_PopulateDynamicCANDB.21.17.ORI

  -- create s3 folder
  -- create lambda
  -- trigger on s3 to call lambda
  -- in lambda
    check if al 3 files
    check if valid
    write 2 files to blob fields
    read 3rd file as json and strip out into fields
      Write all this to dynamodb
    write log (success / fail at any of the steps)
  -- DO ALL ABOVE via web first
  -- recreate from code
  -- work into project
  -- check with zonika
