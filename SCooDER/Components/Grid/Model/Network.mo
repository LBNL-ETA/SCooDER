within SCooDER.Components.Grid.Model;
model Network
  "Three phases unbalanced AC network without neutral cable"
  extends Buildings.Electrical.Transmission.BaseClasses.PartialNetwork(
    redeclare
      Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
      terminal,
    redeclare replaceable
      Buildings.Electrical.Transmission.Grids.TestGrid2Nodes grid,
    redeclare SCooDER.Components.Grid.Model.Line lines(commercialCable=
          grid.cables));
  Modelica.Units.SI.Voltage VAbs[3,grid.nNodes] "RMS voltage of the grid nodes";
  Modelica.Units.SI.Voltage Vpu[3,grid.nNodes]
    "Scaled voltage of the grid nodes";
  Real P[3,grid.nNodes](each unit="W") "Phase Active Power";
  Real Q[3,grid.nNodes](each unit="var") "Phase Reactive Power";
  Real S_temp[3,grid.nNodes,2](each unit="VA") "Simlified Power measurements";
equation
  for i in 1:grid.nLinks loop
    connect(lines[i].terminal_p, terminal[grid.fromTo[i,1]]);
    connect(lines[i].terminal_n, terminal[grid.fromTo[i,2]]);
  end for;

  for i in 1:grid.nNodes loop
    VAbs[1,i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal[i].phase[1].v);
    VAbs[2,i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal[i].phase[2].v);
    VAbs[3,i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal[i].phase[3].v);
    for ph in 1:3 loop
      Vpu[ph,i] = VAbs[ph,i] / V_nominal;
      S_temp[ph,i,1:2] = Buildings.Electrical.PhaseSystems.OnePhase.phasePowers_vi(v=terminal[i].phase[ph].v, i=terminal[i].phase[ph].i);
      P[ph,i] = S_temp[ph,i,1];
      Q[ph,i] = S_temp[ph,i,2];
    end for;
  end for;
  annotation (
  defaultComponentName="net",
 Documentation(revisions="<html>
 <ul>
 <li>
March 30, 2015, by Michael Wetter:<br/>
Made <code>network</code> replaceable. This was detected
by the OpenModelica regression tests.
</li>
<li>
October 6, 2014, by Marco Bonvini:<br/>
Revised documentation and model.
</li>
</ul>
</html>", info="<html>
<p>
This model represents a generalized electrical AC three-phase unbalanced network
without neutral cable.
</p>
<p>
See <a href=\"modelica://Buildings.Electrical.Transmission.BaseClasses.PartialNetwork\">
Buildings.Electrical.Transmission.BaseClasses.PartialNetwork</a>
for information about the network model.
</p>
<p>
See <a href=\"modelica://Buildings.Electrical.Transmission.Grids.PartialGrid\">
Buildings.Electrical.Transmission.Grids.PartialGrid</a>
for more information about the topology of the network, such as
the number of nodes, how they are connected, and the length of each connection.
</p>
</html>"));
end Network;
