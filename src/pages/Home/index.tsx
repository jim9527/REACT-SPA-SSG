import React from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";

function Home() {
    return (
      <div className="App">
        <Helmet>
          <meta charSet="utf-8" />
          <title>My React SEO - Homepage</title>
          <link
            rel="canonical"
            href="https://react-seo-demo-dunghd.vercel.app/"
          />
          <meta name="description" content="Simple React SEO Application" />
        </Helmet>
        <h3>Simple React SEO Demo</h3>
        <header className="App-header">
          <Link to="/counter">Go to counter</Link>
        </header>
      </div>
    );
  }

export default Home