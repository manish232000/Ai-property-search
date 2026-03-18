// Amenities Management APIs

export async function setupAmenityApis(app, db) {
  console.log("🚀 Amenities APIs setup started");
  
  // Create tables if they don't exist
  try {
    console.log("📊 Creating amenities table if it doesn't exist...");
    
    // Create amenities table
    await db.execute(`
      CREATE TABLE IF NOT EXISTS amenities (
        amenity_id int NOT NULL AUTO_INCREMENT,
        name varchar(255) NOT NULL UNIQUE,
        description text,
        icon varchar(255),
        created_at timestamp DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (amenity_id)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    
    console.log("✓ Amenities table created/verified successfully");
  } catch (error) {
    console.error("⚠️ Error creating table:", error.message);
  }
  
  // ------------------- Add Amenity -------------------
  app.post("/api/admin/amenity", async (req, res) => {
    console.log("📝 POST /api/admin/amenity called");
    try {
      const { name, description, icon } = req.body;
      
      // Validation
      if (!name) {
        return res.status(400).json({ error: "Amenity name is required" });
      }

      const sql = `
        INSERT INTO amenities (name, description, icon)
        VALUES (?, ?, ?)
      `;

      const values = [name, description || null, icon || null];
      const result = await db.execute(sql, values);

      res.json({ 
        message: "Amenity added successfully!", 
        amenity_id: result[0].insertId 
      });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      if (error.code === "ER_DUP_ENTRY") {
        res.status(400).json({ error: "Amenity with this name already exists" });
      } else {
        res.status(500).json({ error: error.message || "Server error" });
      }
    }
  });

  // ------------------- Get All Amenities -------------------
  app.get("/api/amenities", async (req, res) => {
    try {
      const sql = `
        SELECT amenity_id, name, description, icon
        FROM amenities
        ORDER BY name ASC
      `;
      
      const [amenities] = await db.execute(sql);
      res.json(amenities);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message });
    }
  });

  // ------------------- Get Single Amenity -------------------
  app.get("/api/amenities/:amenity_id", async (req, res) => {
    try {
      const { amenity_id } = req.params;
      
      const sql = `
        SELECT amenity_id, name, description, icon
        FROM amenities
        WHERE amenity_id = ?
      `;
      
      const [amenities] = await db.execute(sql, [amenity_id]);
      
      if (amenities.length === 0) {
        return res.status(404).json({ error: "Amenity not found" });
      }
      
      res.json(amenities[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message });
    }
  });

  // ------------------- Update Amenity -------------------
  app.put("/api/admin/amenity/:amenity_id", async (req, res) => {
    console.log("📝 PUT /api/admin/amenity/:amenity_id called");
    try {
      const { amenity_id } = req.params;
      const { name, description, icon } = req.body;
      
      // Check if amenity exists
      const [amenities] = await db.execute("SELECT * FROM amenities WHERE amenity_id = ?", [amenity_id]);
      if (amenities.length === 0) {
        return res.status(404).json({ error: "Amenity not found" });
      }

      const sql = `
        UPDATE amenities 
        SET name = ?, description = ?, icon = ?
        WHERE amenity_id = ?
      `;

      const values = [name || amenities[0].name, description || amenities[0].description, icon || amenities[0].icon, amenity_id];
      await db.execute(sql, values);

      res.json({ message: "Amenity updated successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      if (error.code === "ER_DUP_ENTRY") {
        res.status(400).json({ error: "Amenity with this name already exists" });
      } else {
        res.status(500).json({ error: error.message || "Server error" });
      }
    }
  });

  // ------------------- Delete Amenity -------------------
  app.delete("/api/admin/amenity/:amenity_id", async (req, res) => {
    console.log("📝 DELETE /api/admin/amenity/:amenity_id called");
    try {
      const { amenity_id } = req.params;
      
      // Check if amenity exists
      const [amenities] = await db.execute("SELECT * FROM amenities WHERE amenity_id = ?", [amenity_id]);
      if (amenities.length === 0) {
        return res.status(404).json({ error: "Amenity not found" });
      }

      const sql = "DELETE FROM amenities WHERE amenity_id = ?";
      await db.execute(sql, [amenity_id]);

      res.json({ message: "Amenity deleted successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  console.log("✓ Amenities APIs setup completed");
}