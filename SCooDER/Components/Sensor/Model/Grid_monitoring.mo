within SCooDER.Components.Sensor.Model;
model Grid_monitoring
              Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n
                                                           terminal_n
    "Electric terminal side p"
    annotation (Placement(transformation(extent={{-8,92},{8,108}}),
        iconTransformation(extent={{-8,92},{8,108}})));
              Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p
                                                           terminal_p
    "Electric terminal side n"
    annotation (Placement(transformation(extent={{-8,-108},{8,-92}}),
        iconTransformation(extent={{-8,-108},{8,-92}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-20,0})));
  Modelica.Blocks.Interfaces.BooleanInput GridConnected
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80}), iconTransformation(extent={{-10,-10},{10,10}},
          origin={-110,60})));
  Modelica.Blocks.Logical.Switch switch_g_s[2]
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Sources.Constant P0(k=0)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Blocks.Logical.Switch switch_g_v
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Logical.Switch switch_g_i
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Logical.Switch switch_i_s[2]
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Logical.Switch switch_i_v
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Logical.Switch switch_i_i
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Modelica.Blocks.Interfaces.RealOutput S[2](each quantity="Power", each unit=
        "W") "Phase powers" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,-60}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,-60})));
  Monitoring monitoring annotation (Placement(transformation(extent={{70,30},{
            110,70}}), iconTransformation(extent={{90,50},{110,70}})));
equation
  connect(switch_g_s[1].u2, GridConnected)
    annotation (Line(points={{38,80},{-120,80}}, color={255,0,255}));
  connect(switch_g_s[2].u2, GridConnected)
    annotation (Line(points={{38,80},{-120,80}}, color={255,0,255}));
  connect(switch_g_i.u2, GridConnected) annotation (Line(points={{38,20},{30,20},
          {30,80},{-120,80}}, color={255,0,255}));
  connect(switch_g_v.u2, GridConnected) annotation (Line(points={{38,50},{30,50},
          {30,80},{-120,80}}, color={255,0,255}));
  connect(switch_i_s[1].u2, GridConnected) annotation (Line(points={{38,-20},{
          30,-20},{30,80},{-120,80}},
                                   color={255,0,255}));
  connect(switch_i_s[2].u2, GridConnected) annotation (Line(points={{38,-20},{
          30,-20},{30,80},{-120,80}},
                                   color={255,0,255}));
  connect(switch_i_v.u2, GridConnected) annotation (Line(points={{38,-50},{30,
          -50},{30,80},{-120,80}},
                              color={255,0,255}));
  connect(switch_i_i.u2, GridConnected) annotation (Line(points={{38,-80},{30,
          -80},{30,80},{-120,80}},
                              color={255,0,255}));
  connect(P0.y, switch_g_v.u3) annotation (Line(points={{-59,60},{26,60},{26,42},
          {38,42}}, color={0,0,127}));
  connect(P0.y, switch_g_i.u3) annotation (Line(points={{-59,60},{26,60},{26,12},
          {38,12}}, color={0,0,127}));
  connect(switch_g_s[1].u3, P0.y) annotation (Line(points={{38,72},{26,72},{26,
          60},{-59,60}}, color={0,0,127}));
  connect(switch_g_s[2].u3, P0.y) annotation (Line(points={{38,72},{26,72},{26,
          60},{-59,60}}, color={0,0,127}));
  connect(switch_i_s[1].u1, P0.y) annotation (Line(points={{38,-12},{26,-12},{
          26,60},{-59,60}}, color={0,0,127}));
  connect(switch_i_s[2].u1, P0.y) annotation (Line(points={{38,-12},{26,-12},{
          26,60},{-59,60}}, color={0,0,127}));
  connect(switch_i_v.u1, P0.y) annotation (Line(points={{38,-42},{26,-42},{26,
          60},{-59,60}}, color={0,0,127}));
  connect(switch_i_i.u1, P0.y) annotation (Line(points={{38,-72},{26,-72},{26,
          60},{-59,60}}, color={0,0,127}));
  connect(switch_g_s.u1, sens.S)
    annotation (Line(points={{38,88},{14,88},{14,6},{-11,6}},
                                                            color={0,0,127}));
  connect(switch_i_s.u3, sens.S) annotation (Line(points={{38,-28},{14,-28},{14,
          6},{-11,6}},
                     color={0,0,127}));
  connect(switch_g_v.u1, sens.V)
    annotation (Line(points={{38,58},{10,58},{10,0},{-11,0}},
                                                            color={0,0,127}));
  connect(switch_i_v.u3, sens.V) annotation (Line(points={{38,-58},{10,-58},{10,
          0},{-11,0}},
                     color={0,0,127}));
  connect(switch_i_i.u3, sens.I) annotation (Line(points={{38,-88},{6,-88},{6,
          -6},{-11,-6}},
                       color={0,0,127}));
  connect(switch_g_i.u1, sens.I) annotation (Line(points={{38,28},{6,28},{6,-6},
          {-11,-6}},   color={0,0,127}));
  connect(S, sens.S) annotation (Line(points={{-110,-60},{-6,-60},{-6,6},{-11,6}},
        color={0,0,127}));
  connect(terminal_n, sens.terminal_n)
    annotation (Line(points={{0,100},{-20,100},{-20,10}},
                                              color={0,120,120}));
  connect(sens.terminal_p, terminal_p)
    annotation (Line(points={{-20,-10},{-20,-100},{0,-100}},
                                                color={0,120,120}));
  connect(switch_g_s[1].y, monitoring.P_Grid) annotation (Line(points={{61,80},
          {80,80},{80,50.1},{90.1,50.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch_g_s[2].y, monitoring.Q_Grid) annotation (Line(points={{61,80},
          {80,80},{80,50.1},{90.1,50.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch_g_v.y, monitoring.V_Grid) annotation (Line(points={{61,50},{80,
          50},{80,50.1},{90.1,50.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch_i_s[1].y, monitoring.P_Island) annotation (Line(points={{61,-20},
          {80,-20},{80,50.1},{90.1,50.1}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch_i_s[2].y, monitoring.Q_Island) annotation (Line(points={{61,-20},
          {80,-20},{80,50.1},{90.1,50.1}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch_i_v.y, monitoring.V_Island) annotation (Line(points={{61,-50},
          {80,-50},{80,50.1},{90.1,50.1}},
                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Grid_monitoring;
