within ;
package SCooDER








annotation (
  uses(
    CyDER(version="1"),
    SmartInverter(version="6"),
      Modelica(version="3.2.3"),
      Complex(version="3.2.3"),
      DymolaCommands(version="1.7"),
      Buildings(version="7.0.0")),
  version="8",
  conversion(noneFromVersion="", noneFromVersion="1",
    noneFromVersion="2",
    noneFromVersion="3",
    noneFromVersion="4",
    noneFromVersion="5",
      noneFromVersion="7"),
Documentation(info="<html>
<p>
The Smart Control of Distributed Energy Resources (<code>SCooDER</code>) library is
a library facilitating the simulation and optimization of distributed energy resources (DERs) such as photovoltaics (PV), battery storage, smart inverters, electric vehicles, and electric power systems.

This package is developed to model various components of the electric power system in the context of future scenarios with high penetrations of DERs. The library is structured in three main categories:

* Solar: This package contains solar irradiaiton models.
* Components: This package contains the component models for various power system devices. It includes: Sensor, Inverter, Transformer, Photovoltacis, Battery, Controller, Grid, uPMU, and Conversion. Each component library contains of a Model and Examples folder.
* Systems: This library contains ensembles of components to form whole systems. An example is the Flexgrid model which consists of three single-phase inverters, three batteries, and a number of sensors. 

*Please note that the SCooDER package and especially the examples are still under development. Please open an issue for specific questions*


<p>
The newest version of this library is available at 
<a href=\"https://github.com/LBNL-ETA/SCooDER\"> https://github.com/LBNL-ETA/SCooDER </a>.

</p>

<p> The package depends on the <a href=\"https://github.com/modelica/ModelicaStandardLibrary\"> Modelica Standard Library </a> and <a href=\"https://github.com/lbl-srg/modelica-buildings\"> Modelica Buildings Library </a>. </p>

Most models are validated with equipment installed at <a href=\"https://lbl.gov\"> Lawrence Berkeley National Laboratory </a>.

<p> Smart Control of Distributed Energy Resources (SCooDER) Copyright (c) 2019, The
Regents of the University of California, through Lawrence Berkeley National
Laboratory (subject to receipt of any required approvals from the U.S.
Dept. of Energy).  All rights reserved. </p>

<p> If you have questions about your rights to use or distribute this software,
please contact Berkeley Lab's Intellectual Property Office at
IPO@lbl.gov. </p>

<p> NOTICE.  This Software was developed under funding from the U.S. Department
of Energy and the U.S. Government consequently retains certain rights.  As
such, the U.S. Government has been granted for itself and others acting on
its behalf a paid-up, nonexclusive, irrevocable, worldwide license in the
Software to reproduce, distribute copies to the public, prepare derivative
works, and perform publicly and display publicly, and to permit other to do
so. </p>

<p> To cite the SCooDER package, please use: <br/>
*Gehbauer, Christoph, Müller, J., Swenson, T. and Vrettos, E. 2019. Photovoltaic and Behind-the-Meter Battery Storage: Advanced Smart Inverter Controls and Field Demonstration. California Energy Commission.* </p>



<p> 

</html>"));


end SCooDER;
