CREATE TABLE "ContainerPlan" ("id" TEXT PRIMARY KEY, "categoryId" TEXT NOT NULL REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE, "number" TEXT NOT NULL, "type" TEXT NOT NULL, "planned" TEXT, "actual" TEXT, "status" TEXT NOT NULL DEFAULT 'Planned', "remarks" TEXT, "generated" BOOLEAN NOT NULL DEFAULT false);
CREATE UNIQUE INDEX "ContainerPlan_categoryId_number_key" ON "ContainerPlan"("categoryId","number");
CREATE TABLE "ContainerItem" ("id" TEXT PRIMARY KEY, "planId" TEXT NOT NULL REFERENCES "ContainerPlan"("id") ON DELETE CASCADE ON UPDATE CASCADE, "masterId" TEXT NOT NULL REFERENCES "PanelMaster"("id") ON DELETE RESTRICT ON UPDATE CASCADE, "quantity" INTEGER NOT NULL);
CREATE UNIQUE INDEX "ContainerItem_planId_masterId_key" ON "ContainerItem"("planId","masterId");
ALTER TABLE "ProductionSet" ADD COLUMN "containerPlanId" TEXT REFERENCES "ContainerPlan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
