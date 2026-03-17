// Project Management APIs

export function setupProjectApis(app, db, upload) {
  // ------------------- Add Project -------------------
  app.post("/api/admin/project", upload.single("image"), async (req, res) => {
    try {
      const { township_id, name, description, phase, status } = req.body;
      
      if (!township_id || !name) {
        return res.status(400).json({ error: "Township ID and Project Name are required" });
      }

      // Verify township exists
      const [township] = await db.execute("SELECT * FROM townships WHERE township_id = ?", [township_id]);
      if (township.length === 0) {
        return res.status(404).json({ error: "Township not found" });
      }

      const image = req.file ? req.file.filename : null;

      const sql = `
        INSERT INTO projects (township_id, name, description, phase, status, image)
        VALUES (?, ?, ?, ?, ?, ?)
      `;

      const values = [township_id, name, description, phase, status || "Planning", image];
      const result = await db.execute(sql, values);

      res.json({ 
        message: "Project added successfully!", 
        project_id: result[0].insertId 
      });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get All Projects -------------------
  app.get("/api/projects", async (req, res) => {
    try {
      const sql = `
        SELECT p.*, t.name as township_name 
        FROM projects p
        JOIN townships t ON p.township_id = t.township_id
        ORDER BY p.created_at DESC
      `;
      const [projects] = await db.execute(sql);
      res.json(projects);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Projects by Township -------------------
  app.get("/api/township/:township_id/projects", async (req, res) => {
    try {
      const { township_id } = req.params;
      const sql = "SELECT * FROM projects WHERE township_id = ? ORDER BY created_at DESC";
      const [projects] = await db.execute(sql, [township_id]);
      res.json(projects);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Project by ID -------------------
  app.get("/api/projects/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const sql = `
        SELECT p.*, t.name as township_name 
        FROM projects p
        JOIN townships t ON p.township_id = t.township_id
        WHERE p.project_id = ?
      `;
      const [projects] = await db.execute(sql, [id]);
      
      if (projects.length === 0) {
        return res.status(404).json({ error: "Project not found" });
      }
      
      res.json(projects[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Update Project -------------------
  app.put("/api/admin/project/:id", upload.single("image"), async (req, res) => {
    try {
      const { id } = req.params;
      const { name, description, phase, status } = req.body;

      const [existing] = await db.execute("SELECT * FROM projects WHERE project_id = ?", [id]);
      if (existing.length === 0) {
        return res.status(404).json({ error: "Project not found" });
      }

      const image = req.file ? req.file.filename : existing[0].image;

      const sql = `
        UPDATE projects 
        SET name = ?, description = ?, phase = ?, status = ?, image = ?
        WHERE project_id = ?
      `;

      const values = [name || existing[0].name, description || existing[0].description, 
                     phase || existing[0].phase, status || existing[0].status, image, id];
      
      await db.execute(sql, values);
      res.json({ message: "Project updated successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Delete Project -------------------
  app.delete("/api/admin/project/:id", async (req, res) => {
    try {
      const { id } = req.params;
      await db.execute("DELETE FROM projects WHERE project_id = ?", [id]);
      res.json({ message: "Project deleted successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });
}
