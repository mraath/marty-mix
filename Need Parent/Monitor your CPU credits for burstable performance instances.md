---
created: 2023-10-20T15:38
updated: 2023-10-20T15:39
---
To monitor your CPU credits for burstable performance instances, you can use the following tools in AWS:

- CloudWatch: You can use Amazon CloudWatch to monitor the CPU utilization and credit balance of your Burstable Performance Instances in real-time and set alarms to alert you when utilization or credits reach a certain threshold. You can also use CloudWatch metrics to calculate the average CPU utilization over a 24-hour period and compare it with the baseline CPU performance of your instance. For more information, see [.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)[1](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)
- EC2 Console: You can access the EC2 Console in the AWS Management Console to view the CPU utilization and credit balance of your instances. You can also change the credit specification of your instances to enable or disable Unlimited mode, which allows you to burst above the baseline for as long as required. For more information, see [.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)[2](https://github.com/awsdocs/amazon-ec2-user-guide/blob/master/doc_source/burstable-performance-instances-monitoring-cpu-credits.md)
- AWS CLI or SDKs: You can use the AWS CLI or SDKs to get the CPU utilization and credit balance of your instances programmatically. You can also use the get-metric-statistics command to get the statistics of any CloudWatch metric for your instance. For more information, see [List metrics using the AWS CLI].

