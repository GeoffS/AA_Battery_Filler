include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCADdesigns/chamferedCylinders.scad>

makeBottomSet = false;
makeTopSet = false;

AA_Length = 50;
AA_Dia = 14;
AA_Button = 1.4;
AA_ButtonDia = 4.5;

wireDia = 1;
wireHoleDia = wireDia + 1;

spacingX = 16;
spacingY = 16;

separatorsInDeviceZ = 18;
connectorOffsetZ = 4;
connectorZ = AA_Length - separatorsInDeviceZ - connectorOffsetZ;
echo(str("connectorZ = ", connectorZ));

module basicThreeByOnePack()
{
	ThreeByOneArray(spacingX, spacingY);
}

cellConnectorY = 6;
module cellConnectorTop()
{
	coZ = AA_Length - connectorOffsetZ - connectorZ;
	tcu([0, -cellConnectorY/2, coZ], [spacingX*2, cellConnectorY, connectorZ]);
}

module cellConnectorBottom()
{
	tcu([0, -cellConnectorY/2, connectorOffsetZ], [spacingX*2, cellConnectorY, connectorZ]);
}

module ThreeByOnePackBottom()
{
	difference()
	{
		basicThreeByOnePack();

		// Add spots for the contact wires:
		wireHoleOffsetX = 4;
		rotate([0,0,-45]) 
		{
			// Recess across the end for electrical contact:
			rotate([0,90,0]) tcy([0,0,-wireHoleOffsetX], d=wireDia, h=20);
			// Hole for the wire end:
			tcy([-wireHoleOffsetX,0,-15], d=wireHoleDia, h=20) ;
		}
	}

	cellConnectorBottom();
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
			tcy([-(AA_ButtonDia/2+1.5),0,-15], d=wireHoleDia, h=20) ;
		}
	}

	cellConnectorTop();
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
	// display() ThreeByOnePackBottom();

	// display() ThreeByOnePackTop();

	display() translate([2*spacingX, 0, AA_Length]) rotate([0,180,0]) ThreeByOnePackBottom();
	display() translate([0, -spacingY, 0]) ThreeByOnePackTop();
}
else
{
	if(makeBottomSet) ThreeByOnePackBottom();
	if(makeTopSet) ThreeByOnePackTop();
}
