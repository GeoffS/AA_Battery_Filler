include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCADdesigns/chamferedCylinders.scad>

AA_Length = 50;
AA_Dia = 14;
AA_Button = 1.4;
AA_ButtonDia = 4.5;

module itemModule()
{
	AABatt();
}

module AABatt()
{
	simpleChamferedCylinderDoubleEnded1(d = AA_Dia, h = AA_Length-AA_Button, cz = 1);
	simpleChamferedCylinderDoubleEnded1(d = AA_ButtonDia, h = AA_Length, cz = 0.6);
}

module clip(d=0)
{
	//tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}
