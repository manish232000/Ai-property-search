// BHK Management APIs

export function setupBhkApis(app, db) {
  console.log("🚀 BHK APIs setup started");
  
  // Create tables if they don't exist
  const initTables = async () => {
    try {
      console.log("📊 Creating BHK table if it doesn't exist...");
      
      // Create bhk_options table
      await db.execute(`
        CREATE TABLE IF NOT EXISTS bhk_options (
          bhk_id int NOT NULL AUTO_INCREMENT,
          bhk int NOT NULL UNIQUE,
          description text,
          created_at timestamp DEFAULT CURRENT_TIMESTAMP,
          PRIMARY KEY (bhk_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);
      
      // Insert default BHK values if empty
      const [rows] = await db.execute("SELECT COUNT(*) as count FROM bhk_options");
      if (rows[0].count === 0) {
        await db.execute("INSERT INTO bhk_options (bhk, description) VALUES (1, '1 Bedroom Kitchen Hall')");
        await db.execute("INSERT INTO bhk_options (bhk, description) VALUES (2, '2 Bedroom Kitchen Hall')");
        await db.execute("INSERT INTO bhk_options (bhk, description) VALUES (3, '3 Bedroom Kitchen Hall')");
        await db.execute("INSERT INTO bhk_options (bhk, description) VALUES (4, '4 Bedroom Kitchen Hall')");
        await db.execute("INSERT INTO bhk_options (bhk, description) VALUES (5, '5 Bedroom Kitchen Hall')");
        console.log("✓ Default BHK values inserted");
      }
      
      console.log("✓ BHK table created/verified successfully");
    } catch (error) {
      console.error("⚠️ Error creating table:", error.message);
    }
  };
  
  // Initialize tables on startup
  initTables();
  
  // ------------------- Get All BHK Options -------------------
  app.get("/api/bhk_options", async (req, res) => {
    try {
      const sql = `
        SELECT bhk_id, bhk, description
        FROM bhk_options
        ORDER BY bhk ASC
      `;
      
      const [bhkOptions] = await db.execute(sql);
      res.json(bhkOptions);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message });
    }
  });

  console.log("✓ BHK APIs setup completed");
}
