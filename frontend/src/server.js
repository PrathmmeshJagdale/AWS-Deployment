const express = require("express");
const axios = require("axios");

const app = express();

const BACKEND_URL = process.env.BACKEND_URL || "http://localhost:5000/api/message";

app.get("/health", (req, res) => {
    res.json({ status: "UP" });
});

app.get("/", async (req, res) => {
    try {
        const response = await axios.get(BACKEND_URL);
        res.json({ 
            service: "Express Frontend",
            backend_response: response.data
        });
    } catch (err) {
        res.status(500).json({ error: "Cannot reach backend", details: err.message });
    }
});

app.listen(3000, "0.0.0.0", () => {
    console.log("Frontend running on port 3000");
});

