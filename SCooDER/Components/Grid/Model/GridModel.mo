within SCooDER.Components.Grid.Model;
model GridModel
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid(f=60, V=208)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load(
    P_nominal=-1200,
    mode=Buildings.Electrical.Types.Load.FixedZ_steady_state,
    V_nominal=120)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Network ieee34(V_nominal=208, redeclare
      Buildings.Electrical.Transmission.Grids.IEEE_34_AL120 grid)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Network ieee13(V_nominal=208, redeclare Records.IEEE_13 grid)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load13(
    P_nominal=-1200,
    mode=Buildings.Electrical.Types.Load.FixedZ_steady_state,
    V_nominal=120)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  connect(grid.terminal, ieee34.terminal[1]) annotation (Line(points={{0,60},{0,
          60},{0,10},{-60,10}}, color={0,120,120}));
  connect(load.terminal, ieee34.terminal[7])
    annotation (Line(points={{20,10},{-20,10},{-60,10}}, color={0,120,120}));
  connect(grid.terminal, ieee13.terminal[1]) annotation (Line(points={{0,60},{0,
          60},{0,-30},{-60,-30}}, color={0,120,120}));
  connect(load13.terminal, ieee13.terminal[13]) annotation (Line(points={{20,
          -30},{-20,-30},{-60,-30}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GridModel;
