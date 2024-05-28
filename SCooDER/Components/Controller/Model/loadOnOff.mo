within SCooDER.Components.Controller.Model;
model loadOnOff
  // This model is based on Buildings.Electrical.Utilities.Controllers.StateMachineVoltCtrl but with low and high voltage disconnect.
  parameter Modelica.Units.SI.Time tDelay=60;
  parameter Real Vmax=1.05;
  parameter Real Vmin=0.95;
  Boolean connected;
  Real tSwitch;
  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput P(start=0)
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y(start=0)
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
initial equation
  connected = true;

equation

  // Output for every state, connected or not
  if connected then
    y = P;
  else
    y = 0.0;
  end if;

algorithm

  // Detect a voltage violation
  when (Vpu > Vmax or Vpu < Vmin) then
    tSwitch := 1e6;
    connected := false;
  end when;

  // Start reconnect once voltage restored
  when (Vpu < Vmax and Vpu > Vmin) then
    tSwitch := time;
  end when;

  // Transition between not connected and connected again after the delay time has been elapsed
  when
      (not connected and time >= tSwitch + tDelay) then
    connected := true;
  end when;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end loadOnOff;
