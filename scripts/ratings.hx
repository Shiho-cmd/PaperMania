function onUpdate(n):Void {
    comboGroup.cameras = [camGame];

    var playerX:Float = boyfriend.x;
    var playerY:Float = boyfriend.y;

    var offsetX:Float = 700; // How far to the right of the player you want the combo to appear
    var offsetY:Float = 150; // How far above the player you want the combo to appear
    
    comboGroup.x = playerX - offsetX;
    comboGroup.y = playerY - offsetY;
}