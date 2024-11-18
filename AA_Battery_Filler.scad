include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCADdesigns/chamferedCylinders.scad>

AA_Length = 50;
AA_Dia = 14;
AA_Button = 1.4;
AA_ButtonDia = 4.5;

wireDia = 1;

module ThreeByOnePack()
{
	spacingX = 16;
	spacingY = 16;

	separatorsZ = 18;
	separatorGapZ = AA_Length-separatorsZ-4;

	difference()
	{
		union()
		{
			ThreeByOneArray(spacingX, spacingY);

			// Connect the cells together:
			y = 6;
			tcu([0,-y/2,separatorsZ], [spacingX*2, y, separatorGapZ]);
		}

		// Add spots for the contact wires:
		rotate([0,0,-45]) rotate([0,90,0]) tcy([0,0,-5], d=wireDia, h=20);
		translate([0,0,AA_Length]) rotate([0,0,-45]) rotate([0,90,0]) tcy([0,0,-5], d=wireDia, h=20);
	}
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
	display() ThreeByOnePack();
}
else
{
	ThreeByOnePack();
}
