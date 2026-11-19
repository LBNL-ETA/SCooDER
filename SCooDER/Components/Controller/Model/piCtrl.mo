within SCooDER.Components.Controller.Model;
model piCtrl
  parameter Real k(min=0, unit="1") = 1 "Gain of controller";
  parameter Real Ti(min=0, unit="1") = 0.5 "Time constant of Integrator block";
  parameter Real p_min(min=0, unit="W") = 0 "Minimum Output";
  parameter Real p_max(min=0, unit="W") = 1000 "Maximum Output";
  parameter Real p_gain(unit="1") = 1 "Measurement gain";
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  LimPID_variable pid(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    y_start=0)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Gain gain(k=-p_gain)
                                           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-50})));
  Modelica.Blocks.Sources.Constant min(k=p_min)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant max(k=p_max)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput
            u_s "Connector of setpoint input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput
            u_m "Connector of measurement input signal" annotation (Placement(
        transformation(
        origin={0,-120},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput
             y "Connector of actuator output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput y_s
    "Connector of actuator output signal"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
equation
  connect(feedback.y, pid.u_s)
    annotation (Line(points={{-41,0},{-12,0}}, color={0,0,127}));
  connect(gain.y, pid.u_m) annotation (Line(points={{2.05391e-15,-39},{2.05391e-15,
          -25.5},{0,-25.5},{0,-12}}, color={0,0,127}));
  connect(min.y, pid.u_min) annotation (Line(points={{-79,-30},{-20,-30},{-20,-8.6},
          {-12,-8.6}}, color={0,0,127}));
  connect(pid.u_max, max.y) annotation (Line(points={{-12,8},{-20,8},{-20,30},{-79,
          30}}, color={0,0,127}));
  connect(gain.u, feedback.u2) annotation (Line(points={{-2.22045e-15,-62},{-2.22045e-15,
          -70},{-50,-70},{-50,-8}}, color={0,0,127}));
  connect(feedback.u1, u_s)
    annotation (Line(points={{-58,0},{-120,0}}, color={0,0,127}));
  connect(gain.u, u_m) annotation (Line(points={{-2.22045e-15,-62},{-2.22045e-15,
          -91},{0,-91},{0,-120}}, color={0,0,127}));
  connect(pid.y, y) annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(feedback.y, y_s) annotation (Line(points={{-41,0},{-30,0},{-30,-80},{
          110,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end piCtrl;
