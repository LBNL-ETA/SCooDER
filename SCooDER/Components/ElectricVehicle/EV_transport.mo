within SCooDER.Components.ElectricVehicle;
model EV_transport
  parameter Integer n_evs=100;
  parameter Integer n_cha=200;
  parameter Integer n_site=10;
  parameter Real EMax[n_evs](each min=0) = 50000*ones(n_evs)
    "EV Battery Capacity [Wh]";
  parameter Real Pmax[n_evs](each min=0) = 10000*ones(n_evs)
    "EV Max Battery Power [W]";
  parameter Real SOC_start[n_evs](each min=0, each max=1) = 0.5*ones(n_evs)
    "EV Initial SOC value";
  parameter Real SOC_min[n_evs](each min=0, each max=1) = 0.1*ones(n_evs)
    "EV Minimum SOC value";
  parameter Real SOC_max[n_evs](each min=0, each max=1) = 1*ones(n_evs)
    "EV Maximum SOC value";
  parameter Real etaCha[n_evs](each min=0, each max=1) = 0.96*ones(n_evs)
    "EV Charging efficiency";
  parameter Real etaDis[n_evs](each min=0, each max=1) = 0.96*ones(n_evs)
    "EV Discharging efficiency";

  //constant Integer n_cha=integer(n_evs*1.5);
  //Real evPset[n_cha];
  //Real chSoc[n_cha];
  //Real chP[n_cha];
  //Integer evLoc[n_cha];
  //Integer chLoc[n_cha];
  //Real dummy = 0;

  Modelica.Blocks.Interfaces.RealInput PPlugCtrl[n_cha](each start=0, each unit="W")
    "EV battery control signal "
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  //Modelica.Blocks.Interfaces.RealOutput EVloc[n_cha] "EV location"
  //  annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput SOC[n_cha] "SOC of battery [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.IntegerInput ev_to_cha[n_evs]
    "Locations of EVs"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));

  /*Battery.Model.Battery EVs[n_evs](
    EMax=cat(1, EMax, 1e-3*ones(n_evs)),
    Pmax=cat(1, Pmax, 0*ones(n_evs)),
    SOC_start=cat(1, SOC_start, 0.1*ones(n_evs)),
    SOC_min=cat(1, SOC_min, 0.1*ones(n_evs)),
    SOC_max=cat(1, SOC_max, 0.1*ones(n_evs)),
    etaCha=cat(1, etaCha, 0.1*ones(n_evs)),
    etaDis=cat(1, etaDis, 0.1*ones(n_evs)))*/
  Battery.Model.Battery EVs[n_evs](
    EMax=EMax,
    Pmax=Pmax,
    SOC_start=SOC_start,
    SOC_min=SOC_min,
    SOC_max=SOC_max,
    etaCha=etaCha,
    etaDis=etaDis)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput P[n_cha](each start=0, each unit="W") "Each charger power"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  //Modelica.Blocks.Sources.RealExpression connections[n_cha](y=evPset)
  //  annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  //Modelica.Blocks.Sources.RealExpression charger_soc[n_cha](y=chSoc)
  //  annotation (Placement(transformation(extent={{60,70},{80,90}})));
  //Modelica.Blocks.Sources.RealExpression charger_P[n_cha](y=chP)
  //  annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  //Modelica.Blocks.Sources.RealExpression ev_loc[n_cha](y=evLoc)
  //  annotation (Placement(transformation(extent={{60,40},{80,60}})));
  //Modelica.Blocks.Sources.RealExpression charger_Pset[n_cha](y=cat(
  //      1,
  //      PPlugCtrl,
  //      zeros(n_evs)))
  //  annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Interfaces.IntegerInput cha_to_ev[n_cha]
    "Locations of EVs"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

  Modelica.Blocks.Interfaces.IntegerInput cha_to_site[n_cha]
    "Locations of EVs"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Interfaces.RealInput PDrive[n_evs](each start=0, each unit="W")
    "EV battery control signal "
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput P_site[n_site](each start=0, each unit="W") "Each site aggregate charger power"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  //when change(ev_to_cha) then
  for i in 1:n_evs loop
    //EVs[i].PCtrl = if ev_to_cha[i] < n_evs then PPlugCtrl[ev_to_cha[i]] else 0;
    EVs[i].PCtrl = if PDrive[i] > -1e-6 then PPlugCtrl[ev_to_cha[i]] else PDrive[i];
  end for;

  for i in 1:n_cha loop
    //evLoc[i] = ev_to_cha[i];
    //chLoc[i] = cha_to_ev[i];
    //evPset[i] = charger_Pset[evLoc[i]].y;
    //evPset[i] = smooth(1, noEvent(if i < n_evs then PPlugCtrl[i] else 0));
    //evPset[i] = noEvent(if ev_to_cha[i] < n_evs then PPlugCtrl[ev_to_cha[i]] else 0);
    //evPset[i] = if cha_to_ev[i] < n_evs then PPlugCtrl[cha_to_ev[i]] else 0;
    //EVs[i].PCtrl = if cha_to_ev[i] < n_evs then PPlugCtrl[cha_to_ev[i]] else 0;
    //chSoc[i] = EVs[ev_to_cha[i]].SOC;
    //SOC[i] = EVs[ev_to_cha[i]].SOC;
    //chP[i] = EVs[ev_to_cha[i]].P;
    //P[i] = EVs[ev_to_cha[i]].P;

    //SOC[i] = if cha_to_ev[i] < n_evs then EVs[cha_to_ev[i]].SOC else 0;
    //P[i] = if cha_to_ev[i] < n_evs then EVs[cha_to_ev[i]].P else 0;

    // NOTE: PDrive[0] should be 1e6 to always default to driving; cha_to_ev 0 when empty

    if cha_to_ev[i] > 0 then
       SOC[i] = EVs[cha_to_ev[i]].SOC;
       P[i] = EVs[cha_to_ev[i]].P;
    else
       SOC[i] = 0;
       P[i] = 0;
    end if;
    //SOC[i] = if PDrive[cha_to_ev[i]] < 1e-6 then EVs[cha_to_ev[i]].SOC else 0;
    //P[i] = if PDrive[cha_to_ev[i]] < 1e-6 then EVs[cha_to_ev[i]].P else 0;
  end for;

  for i in 1:n_site loop
    P_site[i] = sum(if cha_to_site[ii] == i then P[ii] else 0 for ii in 1:n_cha);
  end for;

  //connect(EVs[n_cha].SOC, SOC);
  //connect(EVs.P, P);

  //end when;
  //connect(connections.y, EVs.PCtrl)
  //  annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
  //connect(charger_P.y, P)
  //  annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  //connect(ev_loc.y, EVloc)
  //  annotation (Line(points={{81,50},{110,50}}, color={0,0,127}));
  //connect(charger_soc.y, SOC)
  //  annotation (Line(points={{81,80},{110,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EV_transport;
