---
created: 2023-10-18T07:43
updated: 2023-10-18T07:48
---
Eg. A unit that has a [[pending config]] upload finally is in a state to [[accept]] it a couple of days after it was [[compiled]]. 
Upon [[processing]] the next [[trip]], the [[DIS]] processes the Configuration Accepted [[event]] and [[updates]] the [[status]] of the [[mobile unit]] accordingly. 
The [[user account]] is thus logged as the ==DIS service== user on the database - there is no logical way in which to do this otherwise.

That is but one example where an action that happens in on a unit in the field is recorded on our system.

Parent:: [[Audit]]
