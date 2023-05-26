within SCooDER.Components.ElectricVehicle;
model EV_transport_extTable
  parameter Integer n_evs=200 "number of evs in system";
  parameter Integer n_cha=500 "number of charging stations in system";
  parameter Integer n_site=13 "number of sites in system";
  parameter String fileName="" annotation(Evaluate=false);
  parameter Real startTime=0 "time shift for table to start";
  parameter Real EMax=30e3 "EV battery size in Wh";
  parameter Real Pmax=10e3 "EV max charging and discharging in W";
  parameter Real SOC_start=0.5 "initial soc";

  EV_transport EV_trans(
    n_evs=n_evs,
    n_cha=n_cha,
    n_site=n_site,
    EMax=EMax*ones(n_evs),
    Pmax=Pmax*ones(n_evs),
    SOC_start=SOC_start*ones(n_evs))
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Sources.CombiTimeTable ev_to_cha(
    tableOnFile=true,
    table=fill(
        0.0,
        0,
        0),
    tableName="ev_to_cha",
    fileName=fileName,
    columns=2:n_evs+1,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    startTime=startTime)       annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})),
      __Dymola_HideArray=true);

  Modelica.Blocks.Math.RealToInteger realToInteger1[n_evs]
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Sources.CombiTimeTable cha_to_ev(
    tableOnFile=true,
    table=fill(
        0.0,
        0,
        0),
    tableName="cha_to_ev",
    fileName=fileName,
    columns=2:n_cha+1,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    startTime=startTime)       annotation (Placement(transformation(extent={{-90,-84},{-70,-64}})),
      __Dymola_HideArray=true);

  Modelica.Blocks.Math.RealToInteger realToInteger3[n_cha]
    annotation (Placement(transformation(extent={{-60,-84},{-40,-64}})));
  Modelica.Blocks.Sources.CombiTimeTable cha_to_site(
    tableOnFile=true,
    table=fill(
        0.0,
        0,
        0),
    tableName="cha_to_site",
    fileName=fileName,
    columns=2:n_cha+1,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    startTime=startTime)       annotation (Placement(transformation(extent={{-90,-56},{-70,-36}})),
      __Dymola_HideArray=true);

  Modelica.Blocks.Math.RealToInteger realToInteger2[n_cha]
    annotation (Placement(transformation(extent={{-60,-56},{-40,-36}})));
  Modelica.Blocks.Sources.CombiTimeTable ev_drive_p(
    tableOnFile=true,
    table=fill(
        0.0,
        0,
        0),
    tableName="ev_drive_p",
    fileName=fileName,
    columns=2:n_evs+1,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    startTime=startTime)       annotation (Placement(transformation(extent={{-90,-4},{-70,16}})),
      __Dymola_HideArray=true);

  Modelica.Blocks.Interfaces.RealInput PPlugCtrl[n_cha](each start=0, each unit=
       "W")
    "EV battery control signal "
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  Modelica.Blocks.Interfaces.RealOutput SOC[n_cha] "SOC of battery [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput P[n_cha](each start=0, each unit="W") "Each charger power"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput P_site[n_site](each start=0, each unit="W") "Each site aggregate charger power"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(ev_to_cha.y, realToInteger1.u)
    annotation (Line(points={{-69,-20},{-62,-20}}, color={0,0,127}));
  connect(cha_to_ev.y,realToInteger3. u)
    annotation (Line(points={{-69,-74},{-62,-74}}, color={0,0,127}));
  connect(realToInteger1.y, EV_trans.ev_to_cha) annotation (Line(points={{-39,-20},
          {-26,-20},{-26,-2},{-10,-2}}, color={255,127,0}));
  connect(realToInteger3.y, EV_trans.cha_to_ev) annotation (Line(points={{-39,-74},
          {-22,-74},{-22,-8},{-10,-8}},
                                    color={255,127,0}));
  connect(cha_to_site.y, realToInteger2.u)
    annotation (Line(points={{-69,-46},{-62,-46}}, color={0,0,127}));
  connect(realToInteger2.y, EV_trans.cha_to_site) annotation (Line(points={{-39,-46},
          {-24,-46},{-24,-5},{-10,-5}}, color={255,127,0}));
  connect(ev_drive_p.y, EV_trans.PDrive) annotation (Line(points={{-69,6},{-40,6},
          {-40,1},{-10,1}}, color={0,0,127}));
  connect(PPlugCtrl, EV_trans.PPlugCtrl) annotation (Line(points={{-120,70},{-40,
          70},{-40,8},{-10,8}}, color={0,0,127}));
  connect(EV_trans.P_site, P_site)
    annotation (Line(points={{13,0},{110,0}}, color={0,0,127}));
  connect(EV_trans.P, P) annotation (Line(points={{13,5},{60,5},{60,50},{110,50}},
        color={0,0,127}));
  connect(EV_trans.SOC, SOC) annotation (Line(points={{13,8},{52,8},{52,80},{110,
          80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86000,
      __Dymola_NumberOfIntervals=24,
      __Dymola_Algorithm="Dassl"),
      Evaluate=false);
end EV_transport_extTable;
