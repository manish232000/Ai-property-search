import { setupExampleWithPropertySchema } from "./exampleWithPropertySchema.js";

export async function setupPropertiesAISearchAPIs(app, db) {
  app.get("/api/propSearch/ai", async (req, res) => {
    try {
      console.log("🔍 GET /api/propSearch/ai called");
      console.log("📋 Full req.query:", JSON.stringify(req.query, null, 2));
      console.log("📋 req.url:", req.url);
      console.log("📋 req.originalUrl:", req.originalUrl);

      const userQuery = req.query.query;
      console.log("📋 Extracted userQuery:", userQuery);
      
      if (!userQuery) {
        console.log("❌ Query parameter missing");
        return res.status(400).json({ 
          success: false, 
          error: "query parameter is required",
          receivedParams: req.query,
          example: "/api/propSearch/ai?query=3%20BHK%20apartment%20in%20Jaipur"
        });
      }

      console.log("🤖 Passing to AI:", userQuery);
      // Pass string to AI function
      const sqlQuery = await setupExampleWithPropertySchema(userQuery);

      console.log("Generated SQL Query:\n", sqlQuery);
      const [properties] = await db.execute(sqlQuery);
      
      console.log("📊 Query result:");
      console.log("   - Rows returned:", properties.length);
      console.log("   - Sample data:", properties.slice(0, 2)); // First 2 rows
      console.log("📤 Sending response with", properties.length, "properties");
      const finalResponse = { 
        success: true,
        count: properties.length,
        data: properties 
      };
      console.log("📤 Final Response:", JSON.stringify(finalResponse, null, 2));
      res.json(finalResponse);

    } catch (error) {
      console.error("❌ Error in GET /api/propSearch/ai:", error.message);
      console.error("❌ Full error:", error);
      res.status(500).json({ 
        success: false, 
        error: error.message,
        stack: error.stack
      });
    }
  });
}
 
