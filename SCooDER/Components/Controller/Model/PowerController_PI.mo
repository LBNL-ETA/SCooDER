within SCooDER.Components.Controller.Model;
model PowerController_PI
  import Modelica.Constants.eps;
  parameter Real p_gen_min = 0 "Min power of Generator [W]";
  parameter Real p_gen_max =  3000 "Max power of Generator [W]";
  parameter Real p_batt_min = -5000 "Min power of Battery [W]";
  parameter Real p_batt_max = 5000 "Max power of Battery [W]";
  parameter Real p_pv_max = 4000 "Max power of PV [W]";
  parameter Real p_load_max = 4000 "Max power of Load shedding [W]";
  parameter Real batt_g_gen = 1 "Prefer battery over generator (>0.5)? [-]";

  SCooDER.Components.DieselGenerator.Model.GenCtrlBus genCtrlBus annotation (
      Placement(transformation(extent={{90,-80},{130,-40}}), iconTransformation(
          extent={{-10,-110},{10,-90}})));
  Inverter.Interfaces.InvCtrlBus_single invBattCtrlBus annotation (Placement(
        transformation(extent={{90,-40},{130,0}}), iconTransformation(extent={{
            -50,-110},{-30,-90}})));
  Inverter.Interfaces.InvCtrlBus_single invPVCtrlBus annotation (Placement(
        transformation(extent={{90,60},{130,100}}), iconTransformation(extent={
            {-90,-110},{-70,-90}})));
  Modelica.Blocks.Interfaces.RealInput S[2](
    each final quantity="Power",
    each final unit="W")
    "Phase powers"
                  annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,66}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,110})));
  Modelica.Blocks.Interfaces.BooleanInput GridConnected
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-90,120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,110})));
  SCooDER.Components.Load.Model.LoadCtrlBus loadHighCtrlBus annotation (
      Placement(transformation(extent={{90,30},{130,70}}), iconTransformation(
          extent={{30,-110},{50,-90}})));

  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{10,-82},{30,-62}})));
  SCooDER.Components.Controller.Model.LimPID_variable PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2,
    y_start=0)
    annotation (Placement(transformation(extent={{38,-82},{58,-62}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={48,-92})));
  Modelica.Blocks.Sources.Constant Q0(k=0)
    annotation (Placement(transformation(extent={{68,88},{80,100}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-78,64},{-66,76}})));
  Modelica.Blocks.Sources.Constant Min1(k=p_gen_min)
    annotation (Placement(transformation(extent={{22,-92},{30,-84}})));
  Modelica.Blocks.Sources.Constant Max1(k=p_gen_max)
    annotation (Placement(transformation(extent={{20,-60},{28,-52}})));
  Modelica.Blocks.Sources.Constant P0(k=0)
    annotation (Placement(transformation(extent={{-98,74},{-90,82}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  SCooDER.Components.Controller.Model.LimPID_variable PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2,
    y_start=0) annotation (Placement(transformation(extent={{8,-20},{28,0}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={18,-30})));
  Modelica.Blocks.Sources.Constant Min2(k=p_batt_min)
    annotation (Placement(transformation(extent={{-8,-30},{0,-22}})));
  Modelica.Blocks.Sources.Constant Max2(k=p_batt_max)
    annotation (Placement(transformation(extent={{-8,2},{0,10}})));
  Modelica.Blocks.Math.Feedback feedback3
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  SCooDER.Components.Controller.Model.LimPID_variable PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2,
    y_start=0) annotation (Placement(transformation(extent={{-22,60},{-2,80}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={-12,50})));
  Modelica.Blocks.Sources.Constant Min3(k=-p_pv_max)
    annotation (Placement(transformation(extent={{-38,46},{-30,54}})));
  Modelica.Blocks.Sources.Constant Max3(k=p_load_max)
    annotation (Placement(transformation(extent={{-38,82},{-30,90}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{42,64},{52,74}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{42,50},{52,60}})));
  Modelica.Blocks.Logical.Less less1
    annotation (Placement(transformation(extent={{20,64},{30,74}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{20,50},{30,60}})));
  Modelica.Blocks.Sources.Constant Zero(k=0)
    annotation (Placement(transformation(extent={{0,88},{12,100}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{30,34},{20,44}})));
  Modelica.Blocks.Math.Gain gain4(k=-1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=0,
        origin={6,40})));
  Modelica.Blocks.Interfaces.RealInput PBattCtrl
    annotation (Placement(transformation(extent={{-140,-2},{-100,38}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput PGenCtrl
    annotation (Placement(transformation(extent={{-140,-68},{-100,-28}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{66,2},{78,14}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{68,-58},{80,-46}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{-40,-16},{-28,-4}})));
  Modelica.Blocks.Logical.Switch switch8
    annotation (Placement(transformation(extent={{-40,-78},{-28,-66}})));
  Modelica.Blocks.Sources.BooleanExpression battery_pref(y=if batt_g_gen > 0.5
         then true else false)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Math.Gain gain5(k=-1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-70,18})));
  SCooDER.Components.Load.Model.LoadCtrlBus loadLowCtrlBus annotation (
      Placement(transformation(extent={{90,6},{130,46}}), iconTransformation(
          extent={{70,-110},{90,-90}})));
  Modelica.Blocks.Logical.Switch switch9
    annotation (Placement(transformation(extent={{84,46},{92,54}})));
  Modelica.Blocks.Logical.Switch switch10
    annotation (Placement(transformation(extent={{84,26},{92,34}})));
  SCooDER.Components.Load.Model.Load_curtail cur_low(delay_on(displayUnit="s"),
      thr=p_load_max*0.5)
    annotation (Placement(transformation(extent={{66,26},{74,34}})));
  SCooDER.Components.Load.Model.Load_curtail cur_high(delay_on(displayUnit="s")
       = 30*60, thr=p_load_max*0.9)
    annotation (Placement(transformation(extent={{66,46},{74,54}})));
equation

  connect(feedback1.y,PID1. u_s)
    annotation (Line(points={{29,-72},{36,-72}}, color={0,0,127}));
  connect(Q0.y, genCtrlBus.qctrl) annotation (Line(points={{80.6,94},{96,94},{96,
          -59.9},{110.1,-59.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q0.y, invBattCtrlBus.qctrl) annotation (Line(points={{80.6,94},{96,94},
          {96,-19.9},{110.1,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q0.y, invPVCtrlBus.qctrl) annotation (Line(points={{80.6,94},{96,94},{
          96,80.1},{110.1,80.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q0.y, loadHighCtrlBus.qctrl) annotation (Line(points={{80.6,94},{96,
          94},{96,50.1},{110.1,50.1}},
                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain1.y, PID1.u_m)
    annotation (Line(points={{48,-87.6},{48,-84}}, color={0,0,127}));
  connect(feedback1.u2, gain1.u) annotation (Line(points={{20,-80},{20,-98},{48,
          -98},{48,-96.8}}, color={0,0,127}));
  connect(gain1.u, genCtrlBus.p) annotation (Line(points={{48,-96.8},{48,-98},{96,
          -98},{96,-59.9},{110.1,-59.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Min1.y, PID1.u_min) annotation (Line(points={{30.4,-88},{32,-88},{32,
          -80},{36,-80},{36,-80.6}},
                       color={0,0,127}));
  connect(PID1.u_max, Max1.y) annotation (Line(points={{36,-64},{32,-64},{32,
          -56},{28.4,-56}},
                       color={0,0,127}));
  connect(switch1.u2, GridConnected) annotation (Line(points={{-79.2,70},{-90,70},
          {-90,120}},           color={255,0,255}));
  connect(P0.y, switch1.u1)
    annotation (Line(points={{-89.6,78},{-86,78},{-86,74.8},{-79.2,74.8}},
                                                   color={0,0,127}));
  connect(S[1], switch1.u3) annotation (Line(points={{-120,61},{-120,65.2},{-79.2,
          65.2}},    color={0,0,127}));
  connect(feedback2.y,PID2. u_s)
    annotation (Line(points={{-1,-10},{6,-10}},  color={0,0,127}));
  connect(gain2.y, PID2.u_m)
    annotation (Line(points={{18,-25.6},{18,-22}}, color={0,0,127}));
  connect(feedback2.u2, gain2.u) annotation (Line(points={{-10,-18},{-10,-36},{
          18,-36},{18,-34.8}},
                            color={0,0,127}));
  connect(Min2.y, PID2.u_min) annotation (Line(points={{0.4,-26},{4,-26},{4,
          -18.6},{6,-18.6}},
                      color={0,0,127}));
  connect(PID2.u_max, Max2.y) annotation (Line(points={{6,-2},{4,-2},{4,6},{0.4,
          6}},  color={0,0,127}));
  connect(gain2.u, invBattCtrlBus.p) annotation (Line(points={{18,-34.8},{18,-36},
          {30,-36},{30,-19.9},{110.1,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(feedback3.y,PID3. u_s)
    annotation (Line(points={{-31,70},{-24,70}}, color={0,0,127}));
  connect(gain3.y, PID3.u_m)
    annotation (Line(points={{-12,54.4},{-12,58}}, color={0,0,127}));
  connect(feedback3.u2, gain3.u) annotation (Line(points={{-40,62},{-40,40},{
          -12,40},{-12,45.2}},
                          color={0,0,127}));
  connect(Min3.y, PID3.u_min) annotation (Line(points={{-29.6,50},{-26,50},{-26,
          61.4},{-24,61.4}}, color={0,0,127}));
  connect(PID3.u_max, Max3.y) annotation (Line(points={{-24,78},{-26,78},{-26,
          86},{-29.6,86}},
                       color={0,0,127}));
  connect(switch1.y, feedback3.u1) annotation (Line(points={{-65.4,70},{-48,70}},
                         color={0,0,127}));
  connect(switch2.y, invPVCtrlBus.pctrl) annotation (Line(points={{52.5,69},{96,
          69},{96,80.1},{110.1,80.1}},
                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greater.y, switch3.u2)
    annotation (Line(points={{30.5,55},{41,55}},
                                               color={255,0,255}));
  connect(less1.y, switch2.u2)
    annotation (Line(points={{30.5,69},{41,69}},
                                               color={255,0,255}));
  connect(Zero.y, less1.u2) annotation (Line(points={{12.6,94},{14,94},{14,65},{
          19,65}},  color={0,0,127}));
  connect(greater.u2, less1.u2) annotation (Line(points={{19,51},{14,51},{14,65},
          {19,65}}, color={0,0,127}));
  connect(PID3.y, greater.u1)
    annotation (Line(points={{-1,70},{16,70},{16,55},{19,55}},
                                                             color={0,0,127}));
  connect(less1.u1, greater.u1)
    annotation (Line(points={{19,69},{16,69},{16,55},{19,55}},
                                                             color={0,0,127}));
  connect(switch3.u3, less1.u2) annotation (Line(points={{41,51},{36,51},{36,78},
          {14,78},{14,65},{19,65}}, color={0,0,127}));
  connect(switch2.u1, switch3.u1)
    annotation (Line(points={{41,73},{40,73},{40,72},{38,72},{38,58},{41,58},{
          41,59}},                                     color={0,0,127}));
  connect(switch3.u1, greater.u1) annotation (Line(points={{41,59},{41,58},{38,
          58},{38,80},{16,80},{16,55},{19,55}},
                               color={0,0,127}));
  connect(switch2.u3, less1.u2) annotation (Line(points={{41,65},{36,65},{36,78},
          {14,78},{14,65},{19,65}}, color={0,0,127}));
  connect(switch4.u2, switch3.u2) annotation (Line(points={{31,39},{34,39},{34,
          55},{41,55}}, color={255,0,255}));
  connect(gain4.y, gain3.u)
    annotation (Line(points={{1.6,40},{-12,40},{-12,45.2}}, color={0,0,127}));
  connect(switch3.y, switch4.u1) annotation (Line(points={{52.5,55},{54,55},{54,
          43},{31,43}}, color={0,0,127}));
  connect(switch2.y, switch4.u3) annotation (Line(points={{52.5,69},{58,69},{58,
          35},{31,35}}, color={0,0,127}));
  connect(gain4.u, switch4.y) annotation (Line(points={{10.8,40},{20,40},{20,39},
          {19.5,39}}, color={0,0,127}));
  connect(PID2.y, switch5.u3) annotation (Line(points={{29,-10},{64.8,-10},{
          64.8,3.2}}, color={0,0,127}));
  connect(switch5.y, invBattCtrlBus.pctrl) annotation (Line(points={{78.6,8},{84,
          8},{84,-19.9},{110.1,-19.9}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch5.u2, GridConnected) annotation (Line(points={{64.8,8},{58,8},{
          58,26},{-90,26},{-90,120}}, color={255,0,255}));
  connect(switch6.u2, GridConnected) annotation (Line(points={{66.8,-52},{58,
          -52},{58,26},{-90,26},{-90,120}}, color={255,0,255}));
  connect(PGenCtrl, switch6.u1) annotation (Line(points={{-120,-48},{66.8,-48},{
          66.8,-47.2}},  color={0,0,127}));
  connect(PID1.y, switch6.u3) annotation (Line(points={{59,-72},{62,-72},{62,
          -56.8},{66.8,-56.8}}, color={0,0,127}));
  connect(switch6.y, genCtrlBus.pctrl) annotation (Line(points={{80.6,-52},{94,-52},
          {94,-59.9},{110.1,-59.9}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(feedback2.u1, switch7.y)
    annotation (Line(points={{-18,-10},{-27.4,-10}}, color={0,0,127}));
  connect(PID3.u_s, switch7.u3) annotation (Line(points={{-24,70},{-28,70},{-28,
          6},{-46,6},{-46,-14.8},{-41.2,-14.8}}, color={0,0,127}));
  connect(switch8.y, feedback1.u1)
    annotation (Line(points={{-27.4,-72},{12,-72}}, color={0,0,127}));
  connect(feedback2.y, switch8.u3) annotation (Line(points={{-1,-10},{0,-10},{0,
          -80},{-46,-80},{-46,-76.8},{-41.2,-76.8}}, color={0,0,127}));
  connect(switch8.u2, switch7.u2) annotation (Line(points={{-41.2,-72},{-50,-72},
          {-50,-10},{-41.2,-10}}, color={255,0,255}));
  connect(switch8.u1, switch7.u3) annotation (Line(points={{-41.2,-67.2},{-46,-67.2},
          {-46,-14.8},{-41.2,-14.8}}, color={0,0,127}));
  connect(feedback1.y, switch7.u1) annotation (Line(points={{29,-72},{28,-72},{28,
          -62},{-54,-62},{-54,-5.2},{-41.2,-5.2}}, color={0,0,127}));
  connect(battery_pref.y, switch7.u2)
    annotation (Line(points={{-59,-10},{-41.2,-10}}, color={255,0,255}));
  connect(PBattCtrl, gain5.u)
    annotation (Line(points={{-120,18},{-74.8,18}}, color={0,0,127}));
  connect(gain5.y, switch5.u1) annotation (Line(points={{-65.6,18},{64.8,18},{
          64.8,12.8}}, color={0,0,127}));
  connect(Q0.y, loadLowCtrlBus.qctrl) annotation (Line(points={{80.6,94},{96,94},
          {96,26.1},{110.1,26.1}},                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch10.y, loadLowCtrlBus.pctrl) annotation (Line(points={{92.4,30},
          {96,30},{96,26},{104,26},{104,26.1},{110.1,26.1}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch9.y, loadHighCtrlBus.pctrl) annotation (Line(points={{92.4,50},
          {96,50},{96,50.1},{110.1,50.1}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch10.u2, cur_low.cur)
    annotation (Line(points={{83.2,30},{74.4,30}}, color={255,0,255}));
  connect(cur_high.cur, switch9.u2)
    annotation (Line(points={{74.4,50},{83.2,50}}, color={255,0,255}));
  connect(switch10.u1, loadLowCtrlBus.p_in) annotation (Line(points={{83.2,33.2},
          {82,33.2},{82,40},{96,40},{96,26},{110,26}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch9.u1, loadHighCtrlBus.p_in) annotation (Line(points={{83.2,53.2},
          {82,53.2},{82,62},{96,62},{96,50},{110,50}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch9.u3, Zero.y) annotation (Line(points={{83.2,46.8},{80,46.8},{
          80,84},{14,84},{14,94},{12.6,94}}, color={0,0,127}));
  connect(switch10.u3, Zero.y) annotation (Line(points={{83.2,26.8},{80,26.8},{
          80,84},{14,84},{14,94},{12.6,94}}, color={0,0,127}));
  connect(switch3.y, cur_low.ctrl) annotation (Line(points={{52.5,55},{62,55},{
          62,30},{65.6,30}}, color={0,0,127}));
  connect(cur_high.ctrl, cur_low.ctrl) annotation (Line(points={{65.6,50},{62,
          50},{62,30},{65.6,30}}, color={0,0,127}));
  connect(cur_high.rst, GridConnected) annotation (Line(points={{65.6,47.2},{60,
          47.2},{60,26},{-90,26},{-90,120}}, color={255,0,255}));
  connect(cur_low.rst, GridConnected) annotation (Line(points={{65.6,27.2},{
          65.6,28},{60,28},{60,26},{-90,26},{-90,120}}, color={255,0,255}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerController_PI;
