// Apartment Management APIs

export function setupApartmentApis(app, db, upload) {
  // ------------------- Add Apartment -------------------
  app.post("/api/admin/apartment", upload.single("image"), async (req, res) => {
    try {
      const { building_id, unit, apartment_number, floor, bhk, carpet_area, built_area, price, status, amenities } = req.body;
      
      if (!building_id || !apartment_number || !floor || !bhk || !carpet_area || !price) {
        return res.status(400).json({ error: "Building ID, Apartment Number, Floor, BHK, Carpet Area and Price are required" });
      }

      // Verify building exists
      const [building] = await db.execute("SELECT * FROM buildings WHERE building_id = ?", [building_id]);
      if (building.length === 0) {
        return res.status(404).json({ error: "Building not found" });
      }

      const image = req.file ? req.file.filename : null;
      const floorNum = parseInt(floor);
      const bhkNum = parseInt(bhk);
      const carpetAreaNum = parseFloat(carpet_area);
      const builtAreaNum = built_area ? parseFloat(built_area) : null;
      const priceNum = parseFloat(price);

      const sql = `
        INSERT INTO apartments (building_id, unit, apartment_number, floor, bhk, carpet_area, built_area, price, status, amenities, image)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      `;

      const values = [building_id, unit || null, apartment_number, floorNum, bhkNum, carpetAreaNum, builtAreaNum, priceNum, status || "Available", amenities, image];
      const result = await db.execute(sql, values);

      res.json({ 
        message: "Apartment added successfully!", 
        apartment_id: result[0].insertId 
      });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get All Apartments -------------------
  app.get("/api/apartments", async (req, res) => {
    try {
      const sql = `
        SELECT a.*, b.name as building_name, p.name as project_name, t.name as township_name
        FROM apartments a
        JOIN buildings b ON a.building_id = b.building_id
        JOIN projects p ON b.project_id = p.project_id
        JOIN townships t ON p.township_id = t.township_id
        ORDER BY a.created_at DESC
      `;
      const [apartments] = await db.execute(sql);
      res.json(apartments);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Apartments by Building -------------------
  app.get("/api/building/:building_id/apartments", async (req, res) => {
    try {
      const { building_id } = req.params;
      const sql = "SELECT * FROM apartments WHERE building_id = ? ORDER BY floor, apartment_number";
      const [apartments] = await db.execute(sql, [building_id]);
      res.json(apartments);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Apartments by Project -------------------
  app.get("/api/project/:project_id/apartments", async (req, res) => {
    try {
      const { project_id } = req.params;
      const sql = `
        SELECT a.* FROM apartments a
        JOIN buildings b ON a.building_id = b.building_id
        WHERE b.project_id = ?
        ORDER BY a.created_at DESC
      `;
      const [apartments] = await db.execute(sql, [project_id]);
      res.json(apartments);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Apartment by ID -------------------
  app.get("/api/apartments/:id", async (req, res) => {
    try {
      const { id } = req.params;
      const sql = `
        SELECT a.*, b.name as building_name, b.block, p.name as project_name, t.name as township_name
        FROM apartments a
        JOIN buildings b ON a.building_id = b.building_id
        JOIN projects p ON b.project_id = p.project_id
        JOIN townships t ON p.township_id = t.township_id
        WHERE a.apartment_id = ?
      `;
      const [apartments] = await db.execute(sql, [id]);
      
      if (apartments.length === 0) {
        return res.status(404).json({ error: "Apartment not found" });
      }
      
      res.json(apartments[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Update Apartment -------------------
  app.put("/api/admin/apartment/:id", upload.single("image"), async (req, res) => {
    try {
      const { id } = req.params;
      const { apartment_number, floor, bhk, carpet_area, built_area, price, status, amenities } = req.body;

      const [existing] = await db.execute("SELECT * FROM apartments WHERE apartment_id = ?", [id]);
      if (existing.length === 0) {
        return res.status(404).json({ error: "Apartment not found" });
      }

      const image = req.file ? req.file.filename : existing[0].image;
      const floorNum = floor ? parseInt(floor) : existing[0].floor;
      const bhkNum = bhk ? parseInt(bhk) : existing[0].bhk;
      const carpetAreaNum = carpet_area ? parseFloat(carpet_area) : existing[0].carpet_area;
      const builtAreaNum = built_area ? parseFloat(built_area) : existing[0].built_area;
      const priceNum = price ? parseFloat(price) : existing[0].price;

      const sql = `
        UPDATE apartments 
        SET apartment_number = ?, floor = ?, bhk = ?, carpet_area = ?, built_area = ?, price = ?, status = ?, amenities = ?, image = ?
        WHERE apartment_id = ?
      `;

      const values = [apartment_number || existing[0].apartment_number, floorNum, bhkNum, carpetAreaNum,
                     builtAreaNum, priceNum, status || existing[0].status, amenities || existing[0].amenities, image, id];
      
      await db.execute(sql, values);
      res.json({ message: "Apartment updated successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Delete Apartment -------------------
  app.delete("/api/admin/apartment/:id", async (req, res) => {
    try {
      const { id } = req.params;
      await db.execute("DELETE FROM apartments WHERE apartment_id = ?", [id]);
      res.json({ message: "Apartment deleted successfully!" });
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });

  // ------------------- Get Apartment Statistics -------------------
  app.get("/api/statistics/apartments", async (req, res) => {
    try {
      const sql = `
        SELECT 
          COUNT(*) as total_apartments,
          SUM(CASE WHEN status = 'Available' THEN 1 ELSE 0 END) as available,
          SUM(CASE WHEN status = 'Sold' THEN 1 ELSE 0 END) as sold,
          AVG(price) as avg_price,
          MIN(price) as min_price,
          MAX(price) as max_price
        FROM apartments
      `;
      const [stats] = await db.execute(sql);
      res.json(stats[0]);
    } catch (error) {
      console.error("❌ ERROR:", error.message);
      res.status(500).json({ error: error.message || "Server error" });
    }
  });
}
