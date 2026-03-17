// Building Management APIs

export function setupBuildingApis(app, db, upload) {
  // ------------------- Add Building -------------------
  app.post("/api/admin/building", upload.single("image"), async (req, res) => {
    try {
      const { project_id, name, block, floors, status } = req.body;
      
      if (!project_id || !name) {
        return res.status(400).json({ error: "Project ID and Building Name are required" });
      }

      // Verify project exists
      const [project] = await db.execute("SELECT * FROM projects WHERE project_id = ?", [project_id]);
      if (project.length === 0) {
        return res.status(404).json({ error: "Project not found" });
      }

      const image = req.file ? req.file.filename : null;
      const floorsNum = floors ? parseInt(floors) : null;

      const sql = `
        INSERT INTO buildings (project_id, name, block, floors, status, image)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      const values = [project_id, name, block, floorsNum, status || "Under Construction", image];
      const result = await db.execute(sql, values);

      res.json({ 
        message: "Building added successfully!", 
        building_id: result[0].insertId 
      });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get All Buildings -------------------
  app.get("/api/buildings", async (req, res) => {
    try {
      const sql = `
        SELECT b.*, p.name as project_name, t.name as township_name
        FROM buildings b
        JOIN projects p ON b.project_id = p.project_id
        JOIN townships t ON p.township_id = t.township_id
        ORDER BY b.created_at DESC
      `;
      const [buildings] = await db.execute(sql);
      res.json(buildings);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Buildings by Project -------------------
  app.get("/api/project/:project_id/buildings", async (req, res) => {
    try {
      const { project_id } = req.params;
      const sql = "SELECT * FROM buildings WHERE project_id = ? ORDER BY created_at DESC";
      const [buildings] = await db.execute(sql, [project_id]);
      res.json(buildings);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Building by ID -------------------
  app.get("/api/buildings/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const sql = `
        SELECT b.*, p.name as project_name, t.name as township_name
        FROM buildings b
        JOIN projects p ON b.project_id = p.project_id
        JOIN townships t ON p.township_id = t.township_id
        WHERE b.building_id = ?
      `;
      const [buildings] = await db.execute(sql, [id]);
      
      if (buildings.length === 0) {
        return res.status(404).json({ error: "Building not found" });
      }
      
      res.json(buildings[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Update Building -------------------
  app.put("/api/admin/building/:id", upload.single("image"), async (req, res) => {
    try {
      const { id } = req.params;
      const { name, block, floors, status } = req.body;

      const [existing] = await db.execute("SELECT * FROM buildings WHERE building_id = ?", [id]);
      if (existing.length === 0) {
        return res.status(404).json({ error: "Building not found" });
      }

      const image = req.file ? req.file.filename : existing[0].image;
      const floorsNum = floors ? parseInt(floors) : existing[0].floors;

      const sql = `
        UPDATE buildings 
        SET name = ?, block = ?, floors = ?, status = ?, image = ?
        WHERE building_id = ?
      `;

      const values = [name || existing[0].name, block || existing[0].block, floorsNum, 
                     status || existing[0].status, image, id];
      
      await db.execute(sql, values);
      res.json({ message: "Building updated successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Delete Building -------------------
  app.delete("/api/admin/building/:id", async (req, res) => {
    try {
      const { id } = req.params;
      await db.execute("DELETE FROM buildings WHERE building_id = ?", [id]);
      res.json({ message: "Building deleted successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });
}
