## Points to remove
- Overspeed: ['velocity_kmph'] >= speed
- Point Jump: point['velocity_kmph'] <= 0 and point['dist_km'] > 0)
- Avl: point['IsAvl'] or prevpoint['IsAvl']
- New SLC: point['is_sla'] == True
- OLD SLC: point['LegacyEventId'] == '94'

## Multiple SLCs in a row
- [x] Check heading - jy kan met % afwyking toelaat
- Ignore SLCs for 20 mins... from first one, if last one in same state

## Trips to consider
- 2022-05-27 (Loads of Crossings down to 2)
	- START: 10:02:06
		- 10:34:06
	- RESTART: 22:54:06
		- 23:02:06

- 2022-04-02 (Line Jumps)
	- [START]     10:54:55
	- [RESTART] 20:08:55
	- 11:18:55
	- 13:46:55
	- Jumps: 21:28:55, 21:55:55, 22:37:55
	- 20:17:55
	- 22:25:55

- 2022-04-28 (many to 4)
	- xxx

- 2022-04-11 (4 to many with broken future logic)