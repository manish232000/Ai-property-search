// Township Management APIs

export function setupTownshipApis(app, db, upload) {
  console.log("🚀 Township APIs setup started");
  
  // Create tables if they don't exist
  const initTables = async () => {
    try {
      console.log("📊 Creating township tables if they don't exist...");
      
      // Create townships table
      await db.execute(`
        CREATE TABLE IF NOT EXISTS townships (
          township_id int NOT NULL AUTO_INCREMENT,
          name varchar(255) NOT NULL UNIQUE,
          location varchar(255) NOT NULL,
          city varchar(100) NOT NULL,
          latitude decimal(10,7) DEFAULT NULL,
          longitude decimal(10,7) DEFAULT NULL,
          description text,
          total_area_acres decimal(10,2) DEFAULT NULL,
          image varchar(255) DEFAULT NULL,
          created_at timestamp DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (township_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);
      
      // Create projects table
      await db.execute(`
        CREATE TABLE IF NOT EXISTS projects (
          project_id int NOT NULL AUTO_INCREMENT,
          township_id int NOT NULL,
          name varchar(255) NOT NULL,
          description text,
          phase varchar(50),
          status varchar(100) DEFAULT 'Planning',
          image varchar(255),
          created_at timestamp DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (project_id),
          KEY fk_projects_township (township_id),
          CONSTRAINT fk_projects_township FOREIGN KEY (township_id) REFERENCES townships (township_id) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);
      
      // Create buildings table
      await db.execute(`
        CREATE TABLE IF NOT EXISTS buildings (
          building_id int NOT NULL AUTO_INCREMENT,
          project_id int NOT NULL,
          name varchar(100) NOT NULL,
          block varchar(50),
          floors int,
          status varchar(100) DEFAULT 'Under Construction',
          image varchar(255),
          created_at timestamp DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (building_id),
          KEY fk_buildings_project (project_id),
          CONSTRAINT fk_buildings_project FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);
      
      // Create apartments table
      await db.execute(`
        CREATE TABLE IF NOT EXISTS apartments (
          apartment_id int NOT NULL AUTO_INCREMENT,
          building_id int NOT NULL,
          unit varchar(50),
          apartment_number varchar(50) NOT NULL,
          floor int NOT NULL,
          bhk int NOT NULL,
          carpet_area decimal(8,2) NOT NULL,
          built_area decimal(8,2),
          price decimal(15,2) NOT NULL,
          status varchar(100) DEFAULT 'Available',
          amenities text,
          image varchar(255),
          created_at timestamp DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (apartment_id),
          KEY fk_apartments_building (building_id),
          CONSTRAINT fk_apartments_building FOREIGN KEY (building_id) REFERENCES buildings (building_id) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);
      
      console.log("✓ All township tables created/verified successfully");
    } catch (error) {
      console.error("⚠️  Error creating tables:", error.message);
      console.log("⚠️  Continuing without table creation (they might already exist)");
    }
  };
  
  // Initialize tables on startup
  initTables();
  
  // ------------------- Add Township -------------------
  app.post("/api/admin/township", upload.single("image"), async (req, res) => {
    console.log("📝 POST /api/admin/township called");
    try {
      const { name, location, city, latitude, longitude, description, total_area_acres } = req.body;
      
      // Validation
      if (!name || !location || !city) {
        return res.status(400).json({ error: "Name, Location, and City are required" });
      }

      const image = req.file ? req.file.filename : null;
      const latNum = latitude ? parseFloat(latitude) : null;
      const longNum = longitude ? parseFloat(longitude) : null;
      const areaNum = total_area_acres ? parseFloat(total_area_acres) : null;

      const sql = `
        INSERT INTO townships (name, location, city, latitude, longitude, description, total_area_acres, image)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `;

      const values = [name, location, city, latNum, longNum, description, areaNum, image];
      const result = await db.execute(sql, values);

      res.json({ 
        message: "Township added successfully!", 
        township_id: result[0].insertId 
      });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get All Townships -------------------
  app.get("/api/townships", async (req, res) => {
    console.log("📡 GET /api/townships called");
    try {
      const sql = "SELECT * FROM townships ORDER BY created_at DESC";
      const [townships] = await db.execute(sql);
      res.json(townships);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Township by ID -------------------
  app.get("/api/townships/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const sql = "SELECT * FROM townships WHERE township_id = ?";
      const [townships] = await db.execute(sql, [id]);
      
      if (townships.length === 0) {
        return res.status(404).json({ error: "Township not found" });
      }
      
      res.json(townships[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Update Township -------------------
  app.put("/api/admin/township/:id", upload.single("image"), async (req, res) => {
    try {
      const { id } = req.params;
      const { name, location, city, latitude, longitude, description, total_area_acres } = req.body;

      // Get existing township
      const [existing] = await db.execute("SELECT * FROM townships WHERE township_id = ?", [id]);
      if (existing.length === 0) {
        return res.status(404).json({ error: "Township not found" });
      }

      const image = req.file ? req.file.filename : existing[0].image;
      const latNum = latitude ? parseFloat(latitude) : existing[0].latitude;
      const longNum = longitude ? parseFloat(longitude) : existing[0].longitude;
      const areaNum = total_area_acres ? parseFloat(total_area_acres) : existing[0].total_area_acres;

      const sql = `
        UPDATE townships 
        SET name = ?, location = ?, city = ?, latitude = ?, longitude = ?, description = ?, total_area_acres = ?, image = ?
        WHERE township_id = ?
      `;

      const values = [name || existing[0].name, location || existing[0].location, city || existing[0].city, 
                     latNum, longNum, description || existing[0].description, areaNum, image, id];
      
      await db.execute(sql, values);
      res.json({ message: "Township updated successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Delete Township -------------------
  app.delete("/api/admin/township/:id", async (req, res) => {
    try {
      const { id } = req.params;
      await db.execute("DELETE FROM townships WHERE township_id = ?", [id]);
      res.json({ message: "Township deleted successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });
  
  console.log("✓ Township APIs registered successfully");
}
