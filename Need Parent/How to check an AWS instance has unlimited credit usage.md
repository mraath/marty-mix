---
created: 2023-10-20T11:52
updated: 2023-10-20T15:18
---
Parent:: [[AWS]]


To check if a server instance is set up to be [[unlimited credit usage]], you can follow these steps:

- Open the **Amazon EC2 console** and **select** the **instance** that you want to check.
- Choose **Actions**, **Instance settings**, **Change credit specification**.
- In the Credit specification **dialog box**, you can **see** the current credit option for the instance. If it is set to **Unlimited**, then the instance **can burst above** the **baseline** for as long as required. [If it is set to Standard, then the instance can only use the CPU credits that it has earned or accrued.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)[1](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)

You can also monitor your CPU credit usage and balance using Amazon CloudWatch metrics. For more information, see [.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-unlimited-mode.html)[2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances-monitoring-cpu-credits.html)

- [[How to send an alarm when the credit unlimited will incur costs]]
