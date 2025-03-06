When a user performs an action, you sometimes want to let the user know in the UI.
Sometimes you want to display some text or modal once the action is complete.
Sometimes you want to block the user from further interaction.

This eg blocks the user from further interaction.

In the HTML

![[Pasted image 20230103032207.png]]
(This will act as a listener, to display something to block the user)

In the controller
![[Pasted image 20230103032504.png]]
- The first part will set the listener to display the block
- The second will hide it again