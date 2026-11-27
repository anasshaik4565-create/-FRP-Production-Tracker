CREATE TABLE "User" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "email" TEXT NOT NULL,
  "password" TEXT NOT NULL,
  "role" TEXT NOT NULL,
  "active" BOOLEAN NOT NULL DEFAULT true,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "Project" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "code" TEXT NOT NULL,
  "count" INTEGER NOT NULL,
  "active" BOOLEAN NOT NULL DEFAULT true
);
CREATE TABLE "Category" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "projectId" TEXT NOT NULL,
  "name" TEXT NOT NULL
);
CREATE TABLE "PanelMaster" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "categoryId" TEXT NOT NULL,
  "panelName" TEXT,
  "panelId" TEXT,
  "panelArea" DECIMAL(65,30),
  "targetWeight" DECIMAL(65,30),
  "sortOrder" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE "ProductionSet" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "categoryId" TEXT NOT NULL,
  "number" INTEGER NOT NULL
);
CREATE TABLE "SetPanel" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "setId" TEXT NOT NULL,
  "masterId" TEXT NOT NULL
);
CREATE TABLE "ManufacturingStage" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "categoryId" TEXT NOT NULL,
  "name" TEXT NOT NULL,
  "sortOrder" INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE "PanelStageStatus" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "panelId" TEXT NOT NULL,
  "stageId" TEXT NOT NULL,
  "planned" TEXT,
  "actual" TEXT,
  "status" TEXT NOT NULL DEFAULT 'Not Yet Started',
  "qc" TEXT NOT NULL DEFAULT 'Pending',
  "remarks" TEXT
);
CREATE TABLE "ColorSettings" (
  "key" TEXT NOT NULL PRIMARY KEY,
  "color" TEXT NOT NULL
);
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
ALTER TABLE "Category" ADD CONSTRAINT "Category_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE INDEX "Category_projectId_idx" ON "Category" ("projectId");
ALTER TABLE "PanelMaster" ADD CONSTRAINT "PanelMaster_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE INDEX "PanelMaster_categoryId_idx" ON "PanelMaster" ("categoryId");
ALTER TABLE "ProductionSet" ADD CONSTRAINT "ProductionSet_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE UNIQUE INDEX "ProductionSet_categoryId_number_key" ON "ProductionSet" ("categoryId", "number");
ALTER TABLE "SetPanel" ADD CONSTRAINT "SetPanel_setId_fkey" FOREIGN KEY ("setId") REFERENCES "ProductionSet"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "SetPanel" ADD CONSTRAINT "SetPanel_masterId_fkey" FOREIGN KEY ("masterId") REFERENCES "PanelMaster"("id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE UNIQUE INDEX "SetPanel_setId_masterId_key" ON "SetPanel" ("setId", "masterId");
CREATE INDEX "SetPanel_masterId_idx" ON "SetPanel" ("masterId");
ALTER TABLE "ManufacturingStage" ADD CONSTRAINT "ManufacturingStage_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE INDEX "ManufacturingStage_categoryId_idx" ON "ManufacturingStage" ("categoryId");
ALTER TABLE "PanelStageStatus" ADD CONSTRAINT "PanelStageStatus_panelId_fkey" FOREIGN KEY ("panelId") REFERENCES "SetPanel"("id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "PanelStageStatus" ADD CONSTRAINT "PanelStageStatus_stageId_fkey" FOREIGN KEY ("stageId") REFERENCES "ManufacturingStage"("id") ON DELETE CASCADE ON UPDATE CASCADE;
CREATE UNIQUE INDEX "PanelStageStatus_panelId_stageId_key" ON "PanelStageStatus" ("panelId", "stageId");
CREATE INDEX "PanelStageStatus_stageId_idx" ON "PanelStageStatus" ("stageId");
