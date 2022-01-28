up = keyboard_check_pressed(vk_up);
down = keyboard_check_pressed(vk_down);
select = keyboard_check_pressed(vk_enter);

if(up) menuIndex--;
if(down) menuIndex++;
if(menuIndex < 0) menuIndex = array_length(options) - 1;
if(menuIndex == array_length(options)) menuIndex = 0;

if(select){
	if(options[menuIndex] == "quit") game_end();
	else if(options[menuIndex] == "new game") room_goto(Room1);
}

