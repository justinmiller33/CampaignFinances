import shapefile


sf = shapefile.Reader("HOUSE2012_POLY.shp")
shapes = sf.shapes()

