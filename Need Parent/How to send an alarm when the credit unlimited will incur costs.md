---
created: 2023-10-20T12:52
updated: 2023-10-20T13:53
---
One possible way to send an alarm to the config team if the unlimited credit usage will incur charges is to use: 
- **Amazon CloudWatch metrics** and 
- **alarms**, 
- along with Amazon **SNS** and AWS **Lambda**. 

## Here are the steps you could follow:

- Create a CloudWatch **metric** that tracks the credit usage of your server instance. [You can use the CPUCreditUsage metric that is automatically reported by AWS for T2 and T3 instances.](https://amlanscloud.com/teamsalert/)[1](https://amlanscloud.com/teamsalert/)
- Create a CloudWatch **alarm** that triggers when the credit usage metric exceeds a certain threshold for a specified period of time. [You can configure the alarm to send a notification to an SNS topic when it enters the ALARM state.](https://amlanscloud.com/teamsalert/)[2](https://aws.amazon.com/blogs/mt/aws-config-support-for-amazon-cloudwatch-alarms/)
- [[How to trigger an alarm based on an AWS metrics]]
- Create an **SNS** topic that receives the alarm notification and publishes it to a Lambda function. [You can use the AWS Management Console, AWS CLI, or AWS SDKs to create the topic and subscribe the Lambda function to it.](https://amlanscloud.com/teamsalert/)[3](https://bing.com/search?q=send+alarm+to+config+team+AWS)
- Create a **Lambda** function that receives the alarm notification from the SNS topic and sends it to the config team via Microsoft **Teams**. You can use Python or any other supported language to write the function code. [You will also need to add an Incoming Webhook connector to your Teams channel and get its URL.](https://amlanscloud.com/teamsalert/)[4](https://medium.com/@sebastian.phelps/aws-cloudwatch-alarms-on-microsoft-teams-9b5239e23b64)

I hope this helps you with your question. If you need more details, you can refer to the web search results I found for you using Bing. 😊

