within SCooDER.Dynamic.Interfacing.Model;
model Interface_MBL
  Modelica.Electrical.Analog.Interfaces.PositivePin p_i
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n_i
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_v
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  parameter Modelica.Units.SI.Frequency f_max=1000
    "Maximum frequency of interest";
  parameter Modelica.Units.SI.Frequency f_res=60 "Frequency resolution";
  parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";

  Sensor.Model.dynToPQ dynToPQ(
    f_max=f_max,
    f_res=f_res,
    n_out=n_out)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Components.Inverter.Model.InverterLoad_PQ inverterLoad_PQ annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-60})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_n annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-110})));
equation

  connect(dynToPQ.p_i, p_i)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(dynToPQ.n_i, n_i)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(dynToPQ.p_v, p_v)
    annotation (Line(points={{0,10},{0,100}}, color={0,0,255}));
  connect(dynToPQ.q, inverterLoad_PQ.Q) annotation (Line(points={{-3,-11},{-3,-32},
          {6,-32},{6,-48}}, color={0,0,127}));
  connect(dynToPQ.p, inverterLoad_PQ.Pow) annotation (Line(points={{-7,-11},{-7,
          -36},{1.9984e-15,-36},{1.9984e-15,-48}}, color={0,0,127}));
  connect(inverterLoad_PQ.terminal, term_n)
    annotation (Line(points={{0,-70},{0,-110}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Interface_MBL;
