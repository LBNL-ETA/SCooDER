within SCooDER.Systems.IntegratedEnergySystems;
model MicrogridLarge_SmartBuilding
  parameter Integer n_batt = 1;
  MicrogridLarge.MicrogridLarge_multiBatt Microgrid(
    n_batt=n_batt,
    PV_modules=28,                                  term_p(redeclare package
        PhaseSystem = PhaseSystem))
    annotation (Placement(transformation(extent={{20,20},{60,60}})));
  SmartBuilding.smartBuilding_HVAC Building
    annotation (Placement(transformation(extent={{-20,-40},{20,0}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://SCooDER/Systems/SmartBuilding/El_Cajon-Gillespie_Field_AP.mos"),
      computeWetBulbTemperature=true) "Weather data reader"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{90,0},{70,20}})));
  Modelica.Blocks.Interfaces.RealInput gridConnected
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput PBattCtrl[n_batt]
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(
    f=60,
    V=240,
    terminal(redeclare package PhaseSystem = PhaseSystem))
    annotation (Placement(transformation(extent={{30,80},{50,100}})));
  replaceable package PhaseSystem = Buildings.Electrical.PhaseSystems.OnePhase;
equation
  connect(Building.PBui, Microgrid.P_Load_high)
    annotation (Line(points={{22,-20},{42,-20},{42,18}},
                                                      color={0,0,127}));
  connect(weaDat.weaBus, Building.weaBus) annotation (Line(
      points={{-40,-20},{-20,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(Microgrid.weaBus, weaDat.weaBus) annotation (Line(
      points={{20,30},{-30,30},{-30,-20},{-40,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(zero.y, Microgrid.Q_Load_low)
    annotation (Line(points={{69,10},{58,10},{58,18}}, color={0,0,127}));
  connect(Microgrid.P_Load_low, zero.y)
    annotation (Line(points={{54,18},{54,10},{69,10}}, color={0,0,127}));
  connect(Microgrid.Q_Load_high, zero.y)
    annotation (Line(points={{46,18},{46,10},{69,10}}, color={0,0,127}));
  connect(gridConnected, Microgrid.gridConnected) annotation (Line(points={{-120,
          80},{-40,80},{-40,56},{16,56}}, color={0,0,127}));
  connect(PBattCtrl, Microgrid.PBattCtrl)
    annotation (Line(points={{-120,50},{16,50}}, color={0,0,127}));
  connect(Microgrid.PGenCtrl, zero.y)
    annotation (Line(points={{16,44},{8,44},{8,10},{69,10}}, color={0,0,127}));
  connect(grid.terminal, Microgrid.term_p)
    annotation (Line(points={{40,80},{40,60}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MicrogridLarge_SmartBuilding;
