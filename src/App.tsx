import React from "react";
import {
    createBrowserRouter,
    RouterProvider,
} from "react-router-dom";

import "./App.css";
import Home from "./pages/Home";
import Counter from "./pages/Counter";

const router = createBrowserRouter([
    {
        path: "/",
        element: <Home />
    },
    {
        path: '/counter',
        element: <Counter />
    }
]);

function App() {
    return <RouterProvider router={router} />
}

export default App;