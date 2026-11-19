within SCooDER.Components.Controller.Model;
model PowerController_PI_multiBatt
  import Modelica.Constants.eps;
  parameter Real p_gen_min = 0 "Min power of Generator [W]";
  parameter Real p_gen_max =  3000 "Max power of Generator [W]";
  parameter Real p_batt_min = -5000 "Min power of Battery [W]";
  parameter Real p_batt_max = 5000 "Max power of Battery [W]";
  parameter Real p_pv_max = 4000 "Max power of PV [W]";
  parameter Real p_load_max = 4000 "Max power of Load shedding [W]";
  parameter Real batt_g_gen = 1 "Prefer battery over generator (>0.5)? [-]";
  parameter Integer n_batt = 1 "Number of connected batteries";

  SCooDER.Components.DieselGenerator.Model.GenCtrlBus genCtrlBus annotation (
      Placement(transformation(extent={{90,-80},{130,-40}}), iconTransformation(
          extent={{-10,-110},{10,-90}})));
  Inverter.Interfaces.InvCtrlBus_single invBattCtrlBus[n_batt] annotation (
      Placement(transformation(extent={{90,-40},{130,0}}), iconTransformation(
          extent={{-50,-110},{-30,-90}})));
  Inverter.Interfaces.InvCtrlBus_single invPVCtrlBus annotation (Placement(
        transformation(extent={{90,60},{130,100}}), iconTransformation(extent={{
            -90,-110},{-70,-90}})));
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

  Modelica.Blocks.Sources.Constant Q0(k=0)
    annotation (Placement(transformation(extent={{60,88},{72,100}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-72,64},{-60,76}})));
  Modelica.Blocks.Sources.Constant P0(k=0)
    annotation (Placement(transformation(extent={{-88,84},{-76,96}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{42,64},{52,74}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{42,50},{52,60}})));
  Modelica.Blocks.Logical.Less less1
    annotation (Placement(transformation(extent={{20,64},{30,74}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{20,50},{30,60}})));
  Modelica.Blocks.Sources.Constant Zero(k=0)
    annotation (Placement(transformation(extent={{-16,74},{-4,86}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{30,34},{20,44}})));
  Modelica.Blocks.Math.Gain gain4(k=-1)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=0,
        origin={6,40})));
  Modelica.Blocks.Interfaces.RealInput PBattCtrl[n_batt] annotation (Placement(
        transformation(extent={{-140,-2},{-100,38}}), iconTransformation(extent
          ={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput PGenCtrl
    annotation (Placement(transformation(extent={{-140,-68},{-100,-28}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Logical.Switch switch5[n_batt]
    annotation (Placement(transformation(extent={{80,-6},{92,6}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{80,-66},{92,-54}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{-56,-16},{-44,-4}})));
  Modelica.Blocks.Logical.Switch switch8
    annotation (Placement(transformation(extent={{-56,-76},{-44,-64}})));
  Modelica.Blocks.Sources.BooleanExpression battery_pref(y=if batt_g_gen > 0.5
         then true else false)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Math.Gain gain5[n_batt](each k=-1)
                                                annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
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
    annotation (Placement(transformation(extent={{68,26},{76,34}})));
  SCooDER.Components.Load.Model.Load_curtail cur_high(delay_on(displayUnit="s")
       = 30*60, thr=p_load_max*0.9)
    annotation (Placement(transformation(extent={{66,46},{74,54}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=n_batt)
    annotation (Placement(transformation(extent={{40,-14},{48,-6}})));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=n_batt)
    annotation (Placement(transformation(extent={{40,0},{48,8}})));
  Modelica.Blocks.Math.Sum sum1(nin=n_batt)
    annotation (Placement(transformation(extent={{48,-38},{40,-30}})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=n_batt)
    annotation (Placement(transformation(extent={{60,-24},{68,-16}})));
  piCtrl piPvLoad(
    k=10,
    p_min=-p_pv_max,
    p_max=p_load_max)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  piCtrl piBatt(
    k=10,
    p_min=p_batt_min,
    p_max=p_batt_max)
    annotation (Placement(transformation(extent={{-28,-20},{-8,0}})));
  piCtrl piGen(
    k=10,
    p_min=p_gen_min,
    p_max=p_gen_max)
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Modelica.Blocks.Math.Gain gain1(k=1/n_batt)
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={24,-10})));
equation

  connect(Q0.y, genCtrlBus.qctrl) annotation (Line(points={{72.6,94},{96,94},{
          96,-59.9},{110.1,-59.9}},
                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q0.y, invPVCtrlBus.qctrl) annotation (Line(points={{72.6,94},{96,94},
          {96,80.1},{110.1,80.1}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q0.y, loadHighCtrlBus.qctrl) annotation (Line(points={{72.6,94},{96,
          94},{96,50.1},{110.1,50.1}},
                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch1.u2, GridConnected) annotation (Line(points={{-73.2,70},{-90,
          70},{-90,120}},       color={255,0,255}));
  connect(P0.y, switch1.u1)
    annotation (Line(points={{-75.4,90},{-73.2,90},{-73.2,74.8}},
                                                   color={0,0,127}));
  connect(S[1], switch1.u3) annotation (Line(points={{-120,61},{-120,65.2},{
          -73.2,65.2}},
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
  connect(Zero.y, less1.u2) annotation (Line(points={{-3.4,80},{14,80},{14,65},
          {19,65}}, color={0,0,127}));
  connect(greater.u2, less1.u2) annotation (Line(points={{19,51},{14,51},{14,65},
          {19,65}}, color={0,0,127}));
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
  connect(switch3.y, switch4.u1) annotation (Line(points={{52.5,55},{54,55},{54,
          43},{31,43}}, color={0,0,127}));
  connect(switch2.y, switch4.u3) annotation (Line(points={{52.5,69},{58,69},{58,
          35},{31,35}}, color={0,0,127}));
  connect(gain4.u, switch4.y) annotation (Line(points={{10.8,40},{20,40},{20,39},
          {19.5,39}}, color={0,0,127}));
  connect(switch5.y, invBattCtrlBus.pctrl) annotation (Line(points={{92.6,0},{
          96,0},{96,-19.9},{110.1,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch6.u2, GridConnected) annotation (Line(points={{78.8,-60},{34,
          -60},{34,26},{-90,26},{-90,120}}, color={255,0,255}));
  connect(PGenCtrl, switch6.u1) annotation (Line(points={{-120,-48},{78.8,-48},
          {78.8,-55.2}}, color={0,0,127}));
  connect(switch6.y, genCtrlBus.pctrl) annotation (Line(points={{92.6,-60},{94,
          -60},{94,-59.9},{110.1,-59.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switch8.u2, switch7.u2) annotation (Line(points={{-57.2,-70},{-64,-70},
          {-64,-10},{-57.2,-10}}, color={255,0,255}));
  connect(switch8.u1, switch7.u3) annotation (Line(points={{-57.2,-65.2},{-62,
          -65.2},{-62,-14.8},{-57.2,-14.8}},
                                      color={0,0,127}));
  connect(battery_pref.y, switch7.u2)
    annotation (Line(points={{-79,-10},{-57.2,-10}}, color={255,0,255}));
  connect(PBattCtrl, gain5.u)
    annotation (Line(points={{-120,18},{-74.8,18}}, color={0,0,127}));
  connect(gain5.y, switch5.u1) annotation (Line(points={{-65.6,18},{78.8,18},{
          78.8,4.8}},  color={0,0,127}));
  connect(Q0.y, loadLowCtrlBus.qctrl) annotation (Line(points={{72.6,94},{96,94},
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
    annotation (Line(points={{83.2,30},{76.4,30}}, color={255,0,255}));
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
  connect(switch9.u3, Zero.y) annotation (Line(points={{83.2,46.8},{83.2,44},{
          80,44},{80,84},{14,84},{14,80},{-3.4,80}},
                                             color={0,0,127}));
  connect(switch10.u3, Zero.y) annotation (Line(points={{83.2,26.8},{80,26.8},{
          80,84},{14,84},{14,80},{-3.4,80}}, color={0,0,127}));
  connect(switch3.y, cur_low.ctrl) annotation (Line(points={{52.5,55},{62,55},{
          62,30},{67.6,30}}, color={0,0,127}));
  connect(cur_high.ctrl, cur_low.ctrl) annotation (Line(points={{65.6,50},{62,
          50},{62,30},{67.6,30}}, color={0,0,127}));
  connect(cur_high.rst, GridConnected) annotation (Line(points={{65.6,47.2},{60,
          47.2},{60,26},{-90,26},{-90,120}}, color={255,0,255}));
  connect(cur_low.rst, GridConnected) annotation (Line(points={{67.6,27.2},{64,
          27.2},{64,28},{62,28},{62,26},{-90,26},{-90,120}},
                                                        color={255,0,255}));
  connect(replicator.y, switch5.u3) annotation (Line(points={{48.4,-10},{78.8,
          -10},{78.8,-4.8}},color={0,0,127}));
  connect(booleanReplicator.y, switch5.u2)
    annotation (Line(points={{48.4,4},{64,4},{64,0},{78.8,0}},
                                                 color={255,0,255}));
  connect(booleanReplicator.u, GridConnected) annotation (Line(points={{39.2,4},
          {34,4},{34,26},{-90,26},{-90,120}}, color={255,0,255}));
  connect(replicator1.y, invBattCtrlBus.qctrl) annotation (Line(points={{68.4,
          -20},{90,-20},{90,-19.9},{110.1,-19.9}},
                                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(replicator1.u, Q0.y) annotation (Line(points={{59.2,-20},{56,-20},{56,
          -12},{96,-12},{96,94},{60,94},{60,86},{76,86},{76,94},{72.6,94}},
                      color={0,0,127}));
  connect(piPvLoad.u_s, switch1.y)
    annotation (Line(points={{-52,70},{-59.4,70}}, color={0,0,127}));
  connect(piPvLoad.u_m, gain4.y) annotation (Line(points={{-40,58},{-40,48},{-4,
          48},{-4,40},{1.6,40}}, color={0,0,127}));
  connect(piPvLoad.y, greater.u1) annotation (Line(points={{-29,70},{16,70},{16,
          55},{19,55}}, color={0,0,127}));
  connect(piPvLoad.y_s, switch7.u3) annotation (Line(points={{-29,62},{-26,62},
          {-26,6},{-72,6},{-72,-14.8},{-57.2,-14.8}}, color={0,0,127}));
  connect(piBatt.u_m, sum1.y) annotation (Line(points={{-18,-22},{-18,-34},{
          39.6,-34}}, color={0,0,127}));
  connect(piBatt.y_s, switch8.u3) annotation (Line(points={{-7,-18},{-6,-18},{
          -6,-38},{-66,-38},{-66,-76},{-58,-76},{-58,-74.8},{-57.2,-74.8}},
        color={0,0,127}));
  connect(piBatt.u_s, switch7.y)
    annotation (Line(points={{-30,-10},{-43.4,-10}}, color={0,0,127}));
  connect(piGen.y, switch6.u3) annotation (Line(points={{-9,-70},{78.8,-70},{
          78.8,-64.8}}, color={0,0,127}));
  connect(piGen.u_m, genCtrlBus.p) annotation (Line(points={{-20,-82},{-20,-90},
          {110.1,-90},{110.1,-59.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(piGen.u_s, switch8.y)
    annotation (Line(points={{-32,-70},{-43.4,-70}}, color={0,0,127}));
  connect(piGen.y_s, switch7.u1) annotation (Line(points={{-9,-78},{-6,-78},{-6,
          -40},{-40,-40},{-40,0},{-57.2,0},{-57.2,-5.2}}, color={0,0,127}));
  connect(piBatt.y, gain1.u)
    annotation (Line(points={{-7,-10},{19.2,-10}}, color={0,0,127}));
  connect(gain1.y, replicator.u)
    annotation (Line(points={{28.4,-10},{39.2,-10}}, color={0,0,127}));
  connect(sum1.u, invBattCtrlBus.p) annotation (Line(points={{48.8,-34},{96,-34},
          {96,-19.9},{110.1,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerController_PI_multiBatt;
