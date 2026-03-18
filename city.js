// City Management APIs

export function setupCityApis(app, db, upload) {
  console.log("🚀 City APIs setup started");
  
  // Create tables if they don't exist
  const initTables = async () => {
    try {
      console.log("📊 Creating city table if it doesn't exist...");
      
      // Create cities table
      await db.execute(`
        CREATE TABLE IF NOT EXISTS cities (
          city_id int NOT NULL AUTO_INCREMENT,
          name varchar(255) NOT NULL UNIQUE,
          state varchar(255) NOT NULL,
          description text,
          image varchar(255),
          created_at timestamp DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (city_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);
      
      console.log("✓ Cities table created/verified successfully");
    } catch (error) {
      console.error("⚠️ Error creating table:", error.message);
    }
  };
  
  // Initialize tables on startup
  initTables();
  
  // ------------------- Add City -------------------
  app.post("/api/admin/city", upload.single("image"), async (req, res) => {
    console.log("📝 POST /api/admin/city called");
    try {
      const { name, state, description } = req.body;
      
      // Validation
      if (!name || !state) {
        return res.status(400).json({ error: "City name and state are required" });
      }

      const image = req.file ? req.file.filename : null;

      const sql = `
        INSERT INTO cities (name, state, description, image)
        VALUES (?, ?, ?, ?)
      `;

      const values = [name, state, description || null, image];
      const result = await db.execute(sql, values);

      res.json({ 
        message: "City added successfully!", 
        city_id: result[0].insertId 
      });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      if (error.code === "ER_DUP_ENTRY") {
        res.status(400).json({ error: "City with this name already exists" });
      } else {
        res.status(500).json({ error: error.message || "Server error" });
      }
    }
  });

  // ------------------- Get All Cities -------------------
  app.get("/api/cities", async (req, res) => {
    try {
      const sql = `
        SELECT city_id, name, state, description, image
        FROM cities
        ORDER BY name ASC
      `;
      
      const [cities] = await db.execute(sql);
      res.json(cities);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message });
    }
  });

  // ------------------- Get Single City -------------------
  app.get("/api/cities/:city_id", async (req, res) => {
    try {
      const { city_id } = req.params;
      
      const sql = `
        SELECT city_id, name, state, description, image
        FROM cities
        WHERE city_id = ?
      `;
      
      const [cities] = await db.execute(sql, [city_id]);
      
      if (cities.length === 0) {
        return res.status(404).json({ error: "City not found" });
      }
      
      res.json(cities[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message });
    }
  });

  // ------------------- Update City -------------------
  app.put("/api/admin/city/:city_id", upload.single("image"), async (req, res) => {
    console.log("📝 PUT /api/admin/city/:city_id called");
    try {
      const { city_id } = req.params;
      const { name, state, description } = req.body;
      
      // Check if city exists
      const [cities] = await db.execute("SELECT * FROM cities WHERE city_id = ?", [city_id]);
      if (cities.length === 0) {
        return res.status(404).json({ error: "City not found" });
      }

      let image = cities[0].image;
      if (req.file) {
        image = req.file.filename;
      }

      const sql = `
        UPDATE cities 
        SET name = ?, state = ?, description = ?, image = ?
        WHERE city_id = ?
      `;

      const values = [name || cities[0].name, state || cities[0].state, description || cities[0].description, image, city_id];
      await db.execute(sql, values);

      res.json({ message: "City updated successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      if (error.code === "ER_DUP_ENTRY") {
        res.status(400).json({ error: "City with this name already exists" });
      } else {
        res.status(500).json({ error: error.message || "Server error" });
      }
    }
  });

  // ------------------- Delete City -------------------
  app.delete("/api/admin/city/:city_id", async (req, res) => {
    console.log("📝 DELETE /api/admin/city/:city_id called");
    try {
      const { city_id } = req.params;
      
      // Check if city exists
      const [cities] = await db.execute("SELECT * FROM cities WHERE city_id = ?", [city_id]);
      if (cities.length === 0) {
        return res.status(404).json({ error: "City not found" });
      }

      const sql = "DELETE FROM cities WHERE city_id = ?";
      await db.execute(sql, [city_id]);

      res.json({ message: "City deleted successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  console.log("✓ City APIs setup completed");
}
