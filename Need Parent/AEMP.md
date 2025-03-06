---
created: 2023-09-19T10:45
updated: 2024-01-03T10:17
---
## Introduction

Is a [[Device]].
It forms part of the [[Calamp]] device types.
AEMP integration protocol from [[OEM]]s such as [[CAT]], [[John Deere]], [[Komatsu]],
## Property

Needs a new property in the properties xml

## Logicals

It has two new logical devices:
[[BlockManualConfigGroup]] - to block manually create configuration groups. (OEM-543)
[[BlockManalCommisioning]] - to block from being assigned to assets page (OEM-542)
It also has the [[Create default Configuration Group]] logical.

## Events Template

It also has a [[Default Events Template]].
Needs two events
- [[Low Fuel]]
- [[Low DEF]]

## Mobile Device Template

It's [[Default Mobile Device Template]] exposes no settings.
XML snippet: [[XML MobileDevices AEMP]]
SQL to test: [[SQL Device AEMP]]

## Configuration Group

It has a [[Default Configuration Group]].
[[Default Config Group for AEMP]]
SQL to test: [[SQL Configuration Group AEMP]]

