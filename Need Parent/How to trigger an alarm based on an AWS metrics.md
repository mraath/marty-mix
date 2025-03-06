---
created: 2023-10-20T13:53
updated: 2023-10-20T15:38
---
You’re welcome. I’ll repeat the steps for triggering an alarm when the unlimited server is about to start incurring charges. Here they are:

- Open the [[CloudWatch console]] and choose [[AWS Alarms]] from the navigation pane.
- Choose **Create** alarm and **select** [[AWS Metric]].
- Under EC2 Metrics, choose Per-Instance Metrics and select the instance that you want to monitor.
- Choose the CPUCreditUsage metric and choose Select metric.
- Under Conditions, specify the threshold value and the time period for the alarm. For example, you can set the alarm to trigger when the credit usage is greater than 10 for 5 minutes.
- Under Notification, choose an existing SNS topic or create a new one. This is where you will receive the alarm notification when it enters the ALARM state.
- Under Name and description, enter a name and a description for your alarm.
- Choose Create alarm.


## More info on how to test this

Yes, the above steps will work to trigger an alarm to test if the average CPU utilization over a 24-hour period exceeds the baseline, in which case you will incur charges for surplus credits. 
However, you need to make sure:
- that you have enabled **Unlimited** mode for your burstable performance instance, otherwise the alarm will not reflect the actual CPU usage and charges. You can enable Unlimited mode by following the instructions in [.](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)[1](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)

## Calculation

[According to the AWS documentation](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)[2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-credits-baseline-concepts.html), the average CPU utilization over a 24-hour period is calculated by dividing the total number of CPU credits spent by the total number of CPU credits earned in that period. If this ratio is greater than 1, then you have exceeded the baseline and will be charged for the surplus credits. [The charge rate is a flat additional rate per vCPU-hour.](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)[1](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)

You can monitor your CPU credit usage and balance using Amazon CloudWatch metrics. For more information, see [[Monitor your CPU credits for burstable performance instances]]. [You can also use the AWS CLI or SDKs to get the CPU utilization of your EC2 instance using the get-metric-statistics command.](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)[3](https://stackoverflow.com/questions/51541068/what-is-the-best-way-to-get-cpu-utilization-of-ec2-instance-using-aws-command-in) For example, you can use the following command to get the maximum CPU utilization of your instance in the last hour:

```bash
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --period 3600 --statistics Maximum --dimensions Name=InstanceId,Value=$ {instance2} --start-time $ {startTime} --end-time $ {endTime}
```

