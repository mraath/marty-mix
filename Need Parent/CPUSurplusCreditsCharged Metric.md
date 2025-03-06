---
created: 2023-10-20T15:59
updated: 2023-10-20T16:49
---
To use the CPUSurplusCreditsCharged metric to see if **surplus credits** will be used and if so raise an **alarm**, you can follow these steps:

- Open the **CloudWatch** console and choose **Metrics** from the navigation pane.
- Under **EC2 Metrics**, choose **Per-Instance Metrics** and select the **instance** that you want to monitor.
- Choose the CPUSurplusCreditsCharged metric and choose Select metric.
- Under Conditions, specify the threshold value and the time period for the alarm. For example, you can set the alarm to trigger when the **surplus credits charged** are **greater than 0** for **5 minutes**.
- Under Notification, choose an existing **SNS** topic or create a new one. This is where you will receive the alarm notification when it enters the ALARM state.
- Under Name and description, enter a name and a description for your alarm.
- Choose Create alarm.

The CPUSurplusCreditsCharged metric shows the number of surplus CPU credits exceeding the maximum number of CPU credits that can be earned in a 24-hour period, and thus attracting an additional charge. This metric applies only to instances configured as unlimited. [For more information, see [Monitor your CPU credits for burstable performance instances]](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)[1](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)[.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)[1](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)

NAME: CPUSurplusCreditsCharged_Alarm
DESCRIPTION: Notify the Opsgenie-DI-Config SNS Topic when more than 1 credit is being used for the last 5 minutes.


