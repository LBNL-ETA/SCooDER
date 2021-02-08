within SCooDER.Reporting;
model Print_model
equation
   DymolaCommands.Documentation.exportDiagram(
   "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/Models/SmartInverter/export.png",
   width=2000,
   height=2000,
   trim=true,
   modelToExport="SmartInverter.Systems.FLEXGRID");
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Print_model;
