within SCooDER.Components.Controller.Model;
model PowerController
  import Modelica.Constants.eps;
  parameter Modelica.Units.SI.Period timestep=5
    "Time step of the controller in (s)";
  parameter Real tol = 1 "tolerance for power imbalances in (W)";
  SCooDER.Components.DieselGenerator.Model.GenCtrlBus genCtrlBus annotation (
      Placement(transformation(extent={{10,-120},{50,-80}}), iconTransformation(
          extent={{20,-110},{40,-90}})));
  Inverter.Interfaces.InvCtrlBus_single invBattCtrlBus annotation (Placement(
        transformation(extent={{-50,-120},{-10,-80}}), iconTransformation(
          extent={{-40,-110},{-20,-90}})));
  Inverter.Interfaces.InvCtrlBus_single invPVCtrlBus annotation (Placement(
        transformation(extent={{-96,-120},{-56,-80}}), iconTransformation(
          extent={{-100,-110},{-80,-90}})));
  Modelica.Blocks.Interfaces.RealInput S[2](
    each final quantity="Power",
    each final unit="W")
    "Phase powers"
                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,110}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,110})));
  Modelica.Blocks.Interfaces.BooleanInput GridConnected
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  SCooDER.Components.Load.Model.LoadCtrlBus loadCtrlBus annotation (Placement(
        transformation(extent={{70,-120},{110,-80}}), iconTransformation(extent
          ={{80,-110},{100,-90}})));

   Real p_surplus "Active Power imbalance to compensate";
   Real q_surplus "Reactive Power imbalance to compensate";

   Real p_gen;
   Real p_gen_cmd;
   Real p_batt;
   Real p_batt_cmd;
   Real p_pv;
   Real p_pv_cmd;
   Real p_load;
   Real p_load_cmd;
   Real bal_p_gen;
   Real bal_p_batt;
  Modelica.Blocks.Sources.RealExpression write_p_cmd(y=p_pv_cmd)
    annotation (Placement(transformation(extent={{-82,-12},{-72,6}})));
  Modelica.Blocks.Routing.RealPassThrough read_p annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-93,-37})));
  Modelica.Blocks.Routing.RealPassThrough read_q annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-79,-37})));
  Modelica.Blocks.Routing.RealPassThrough read_p1 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-47,-37})));
  Modelica.Blocks.Routing.RealPassThrough read_q1 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-33,-37})));
  Modelica.Blocks.Routing.RealPassThrough read_p2 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={9,-35})));
  Modelica.Blocks.Routing.RealPassThrough read_q2 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={23,-35})));
  Modelica.Blocks.Routing.RealPassThrough read_p3 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={53,-33})));
  Modelica.Blocks.Routing.RealPassThrough read_q3 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={67,-33})));
  Modelica.Blocks.Sources.RealExpression write_q_cmd
    annotation (Placement(transformation(extent={{-82,-26},{-72,-8}})));
  Modelica.Blocks.Sources.RealExpression write_p_cmd1(y=p_batt_cmd)
    annotation (Placement(transformation(extent={{-46,-12},{-36,6}})));
  Modelica.Blocks.Sources.RealExpression write_q_cmd1
    annotation (Placement(transformation(extent={{-46,-26},{-36,-8}})));
  Modelica.Blocks.Sources.RealExpression write_p_cmd2(y=p_gen_cmd)
    annotation (Placement(transformation(extent={{12,-10},{22,8}})));
  Modelica.Blocks.Sources.RealExpression write_q_cmd2
    annotation (Placement(transformation(extent={{12,-26},{22,-8}})));
  Modelica.Blocks.Sources.RealExpression write_p_cmd3(y=p_load_cmd)
    annotation (Placement(transformation(extent={{70,-10},{80,8}})));
  Modelica.Blocks.Sources.RealExpression write_q_cmd3
    annotation (Placement(transformation(extent={{70,-26},{80,-8}})));
equation

  p_surplus = if GridConnected then 0 else S[1];
  q_surplus = if GridConnected then 0 else S[2];
  p_gen = read_p2.y;
  p_batt = read_p1.y;
  p_pv = read_p.y;
  p_load =read_p3.y;

algorithm

  when sample(0,timestep) then

  bal_p_gen :=abs(-p_gen - p_gen_cmd);
  bal_p_batt :=abs(-p_batt - p_batt_cmd);

  p_gen_cmd := if ((bal_p_gen > tol) and p_surplus > 0) then pre(p_gen_cmd) else max(pre(p_gen_cmd) + p_surplus,0);

  p_batt_cmd := if ((bal_p_gen > tol) or (p_gen_cmd < eps and pre(p_batt_cmd) + p_surplus < 0)) then pre(p_batt_cmd) + p_surplus else 0;

  p_load_cmd := if (bal_p_batt > tol and (pre(p_load_cmd) + p_surplus) > 0) then pre(p_load_cmd) + p_surplus else 0;

  p_pv_cmd := if (bal_p_batt > tol and (pre(p_pv_cmd) + p_surplus) < 0) then pre(p_pv_cmd)+p_surplus else 0;

  end when;

equation
  connect(read_p.u, invPVCtrlBus.p) annotation (Line(points={{-93,-43},{-90,-43},
          {-90,-99.9},{-75.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_q.u, invPVCtrlBus.q) annotation (Line(points={{-79,-43},{-79,-70.5},
          {-75.9,-70.5},{-75.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_p1.u, invBattCtrlBus.p) annotation (Line(points={{-47,-43},{-47,-70.5},
          {-29.9,-70.5},{-29.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_q1.u, invBattCtrlBus.q) annotation (Line(points={{-33,-43},{-33,-70.5},
          {-29.9,-70.5},{-29.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_p2.u, genCtrlBus.p) annotation (Line(points={{9,-41},{9,-69.5},{30.1,
          -69.5},{30.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_q2.u, genCtrlBus.q) annotation (Line(points={{23,-41},{23,-64.5},
          {30.1,-64.5},{30.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_p3.u, loadCtrlBus.p) annotation (Line(points={{53,-39},{53,-69.5},
          {90.1,-69.5},{90.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(read_q3.u, loadCtrlBus.p) annotation (Line(points={{67,-39},{67,-67.5},
          {90.1,-67.5},{90.1,-99.9}},
                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_q_cmd3.y, loadCtrlBus.qctrl) annotation (Line(points={{80.5,-17},
          {80.5,-17.5},{90.1,-17.5},{90.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_p_cmd3.y, loadCtrlBus.pctrl) annotation (Line(points={{80.5,-1},
          {80.5,-5.5},{90.1,-5.5},{90.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_p_cmd2.y, genCtrlBus.pctrl) annotation (Line(points={{22.5,-1},{
          22.5,-4.5},{30.1,-4.5},{30.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_q_cmd2.y, genCtrlBus.qctrl) annotation (Line(points={{22.5,-17},
          {30.1,-17},{30.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(write_q_cmd1.y, invBattCtrlBus.qctrl) annotation (Line(points={{-35.5,
          -17},{-35.5,-17.5},{-29.9,-17.5},{-29.9,-99.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_p_cmd1.y, invBattCtrlBus.pctrl) annotation (Line(points={{-35.5,
          -3},{-35.5,-2.5},{-29.9,-2.5},{-29.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_q_cmd.y, invPVCtrlBus.qctrl) annotation (Line(points={{-71.5,-17},
          {-71.5,-82.5},{-75.9,-82.5},{-75.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(write_p_cmd.y, invPVCtrlBus.pctrl) annotation (Line(points={{-71.5,-3},
          {-71.5,-81.5},{-75.9,-81.5},{-75.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PowerController;
