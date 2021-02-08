within SCooDER.Dynamic.Sensor.Model;
model dynToPh
  Modelica.Electrical.Analog.Interfaces.PositivePin p_i
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n_i
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  fft fft_v(
    f_max=f_max,
    f_res=f_res,
    n_out=n_out)
            annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.RealExpression Voltage(y=p_v.v)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.RealExpression Current(y=p_i.i)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  fft fft_i(
    f_max=f_max,
    f_res=f_res,
    n_out=n_out)
            annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
   Modelica.Blocks.Interfaces.RealOutput v_amplitude
    "FFT amplitude of interested frequency band" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={110,70}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={-70,-110},
        rotation=-90)));
   Modelica.Blocks.Interfaces.RealOutput v_phase
    "FFT phase of interested frequency band" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={110,30}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={30,-110},
        rotation=-90)));
   Modelica.Blocks.Interfaces.RealOutput i_amplitude
    "FFT amplitude of interested frequency band" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={110,-30}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={-30,-110},
        rotation=-90)));
   Modelica.Blocks.Interfaces.RealOutput i_phase
    "FFT phase of interested frequency band" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={110,-70}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={70,-110},
        rotation=-90)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_v
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,30})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  parameter Modelica.SIunits.Frequency f_max = 1000
    "Maximum frequency of interest";
  parameter Modelica.SIunits.Frequency f_res = 60
    "Frequency resolution";
  parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";

equation
  connect(Voltage.y, fft_v.u)
    annotation (Line(points={{21,50},{38,50}}, color={0,0,127}));
  connect(Current.y, fft_i.u)
    annotation (Line(points={{21,-50},{38,-50}}, color={0,0,127}));
  connect(fft_v.amplitude, v_amplitude) annotation (Line(points={{61,55},{80,55},
          {80,70},{110,70}}, color={0,0,127}));
  connect(fft_v.phase, v_phase) annotation (Line(points={{61,45},{80,45},{80,30},
          {110,30}}, color={0,0,127}));
  connect(fft_i.amplitude, i_amplitude) annotation (Line(points={{61,-45},{80,-45},
          {80,-30},{110,-30}}, color={0,0,127}));
  connect(fft_i.phase, i_phase) annotation (Line(points={{61,-55},{80,-55},{80,-70},
          {110,-70}}, color={0,0,127}));
  connect(n_i, currentSensor.n)
    annotation (Line(points={{100,0},{-60,0}}, color={0,0,255}));
  connect(currentSensor.p, p_i)
    annotation (Line(points={{-80,0},{-100,0}}, color={0,0,255}));
  connect(voltageSensor.n, n_i)
    annotation (Line(points={{-40,20},{-40,0},{100,0}}, color={0,0,255}));
  connect(voltageSensor.p, p_v) annotation (Line(points={{-40,40},{-40,80},{0,80},
          {0,100}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end dynToPh;
