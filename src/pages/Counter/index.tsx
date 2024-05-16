import React, { useEffect, useState } from "react";
import { Helmet } from "react-helmet";
import { Link } from "react-router-dom";


function Counter() {
    const [dateTime, setDateTime] = useState('')
    const [count, setCount] = useState(0);

    useEffect(() => {
        const t = setInterval(() => {
            const dateString = new Date().toLocaleString("en-US", { hour12: false })
            const hourMinSec = dateString.split(",")[1]

            setDateTime(hourMinSec)
        }, 1000)

        return () => clearInterval(t)
    }, [])

    return (
        <div className="App">
            <Helmet>
                <meta charSet="utf-8" />
                <title>My React SEO - Counter</title>
                <link
                    rel="canonical"
                    href="https://react-seo-demo-dunghd.vercel.app/"
                />
                <meta
                    name="description"
                    content="Simple React SEO Application for counter"
                />
            </Helmet>
            <h3>Simple React SEO Demo - Counter page</h3>
            <header className="App-header">
                <p>
                    <button onClick={() => setCount((count) => count + 1)}>
                        count is: {count}
                    </button>
                </p>
                <p>Simple counter</p>
                {dateTime ? <p> Current local Time: {dateTime} </p> : <p>Loading DateTime...</p>}
                <Link to="/">Back to homepage</Link>
            </header>
        </div>
    );
}

export default Counter