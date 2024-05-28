within SCooDER.Components.Photovoltaics.Examples;
model Comparisons
  "PV module comparisons between simplified, Buildings library and Diode model (TGM library)."
  extends Modelica.Icons.Example;

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
    computeWetBulbTemperature=false)
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Model.PVModule_simple pVModule_simple(
    n=1,
    A=10,
    til=45)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv180deg(
    fAct=1,
    pf=1,
    eta_DCAC=1,
    V_nominal=120,
    eta=0.158,
    A=10,
    til=0.78539816339745,
    azi=3.1415926535898)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage source(f=60, V=120)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv0deg(
    fAct=1,
    pf=1,
    eta_DCAC=1,
    V_nominal=120,
    azi=0,
    A=10,
    eta=0.158,
    til=0.78539816339745)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv90deg(
    fAct=1,
    pf=1,
    eta_DCAC=1,
    V_nominal=120,
    eta=0.158,
    A=10,
    til=0.78539816339745,
    azi=1.5707963267949)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(pVModule_simple.weaBus, weaDatInpCon.weaBus) annotation (Line(
      points={{-20,34},{-40,34},{-40,60},{-60,60}},
      color={255,204,51},
      thickness=0.5));
  connect(pv180deg.weaBus, weaDatInpCon.weaBus) annotation (Line(
      points={{-10,-1},{-40,-1},{-40,60},{-60,60}},
      color={255,204,51},
      thickness=0.5));
  connect(source.terminal, pv180deg.terminal)
    annotation (Line(points={{-60,-10},{-20,-10}}, color={0,120,120}));
  connect(const.y, pVModule_simple.scale) annotation (Line(points={{-59,30},{-50,
          30},{-50,26},{-22,26}}, color={0,0,127}));
  connect(source.terminal, pv0deg.terminal) annotation (Line(points={{-60,
          -10},{-50,-10},{-50,-40},{-20,-40}}, color={0,120,120}));
  connect(source.terminal, pv90deg.terminal) annotation (Line(points={{
          -60,-10},{-50,-10},{-50,-70},{-20,-70}}, color={0,120,120}));
  connect(pv0deg.weaBus, weaDatInpCon.weaBus) annotation (Line(
      points={{-10,-31},{-26,-31},{-40,-31},{-40,-32},{-40,0},{-40,60},{-60,60}},
      color={255,204,51},
      thickness=0.5));
  connect(pv90deg.weaBus, weaDatInpCon.weaBus) annotation (Line(
      points={{-10,-61},{-40,-61},{-40,0},{-40,60},{-60,60}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Comparisons;
