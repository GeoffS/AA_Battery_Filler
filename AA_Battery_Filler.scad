include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCADdesigns/chamferedCylinders.scad>

makeBottomSet = false;
makeTopSet = false;

AA_Length = 50;
AA_Dia = 14;
AA_Button = 1.4;
AA_ButtonDia = 4.5;

wireDia = 1;

spacingX = 16;
spacingY = 16;

separatorsZ = 18;
separatorGapZ = AA_Length-separatorsZ-4;

module basicThreeByOnePack()
{
	ThreeByOneArray(spacingX, spacingY);
}

module cellConnector()
{
	y = 6;
	tcu([0,-y/2,separatorsZ], [spacingX*2, y, separatorGapZ]);
}

module ThreeByOnePackBottom()
{
	difference()
	{
		basicThreeByOnePack();

		// Add spots for the contact wires:
		rotate([0,0,-45]) 
		{
			// Recess across the end for electrical contact:
			rotate([0,90,0]) tcy([0,0,-5], d=wireDia, h=20);
			// Hole for the wire end:
			tcy([-5,0,-15], d=wireDia+0.5, h=20) ;
		}
	}

	cellConnector();
}

module ThreeByOnePackTop()
{
	difference()
	{
		basicThreeByOnePack();

		// Add spots for the contact wires:
		translate([0,0,AA_Length]) rotate([0,0,45]) 
		{
			// Recess across the end for electrical contact:
			rotate([0,90,0]) tcy([0,0,-5], d=wireDia, h=20);
			// Hole for the wire end:
			tcy([-(AA_ButtonDia/2+1.5),0,-15], d=wireDia+0.5, h=20) ;
		}
	}

	cellConnector();
}

module ThreeByOneArray(spacingX, spacingY)
{
	AABatt(         0, 0);
	AABatt(  spacingX, 0);
	AABatt(2*spacingX, 0);
}

module AABatt(x, y)
{
	translate([x, y, 0]) 
	{
		simpleChamferedCylinderDoubleEnded1(d = AA_Dia, h = AA_Length-AA_Button, cz = 1);
		simpleChamferedCylinderDoubleEnded1(d = AA_ButtonDia, h = AA_Length, cz = 0.6);
	}
}

module clip(d=0)
{
	//tc([-200, -400-d, -10], 400);
}

if(developmentRender)
{
	display() translate([2*spacingX, 0, AA_Length]) rotate([0,180,0]) ThreeByOnePackBottom();
	display() translate([0, -spacingY, 0]) ThreeByOnePackTop();
}
else
{
	if(makeBottomSet) ThreeByOnePackBottom();
	if(makeTopSet) ThreeByOnePackTop();
}
