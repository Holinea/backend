import { useEffect, useState } from "react";

export default function PraticiensList() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState("");

  useEffect(() => {
    const url = `${import.meta.env.VITE_API_URL}/praticiens`;
    fetch(url)
      .then(r => {
        if (!r.ok) throw new Error(`HTTP ${r.status}`);
        return r.json();
      })
      .then(setData)
      .catch(e => setErr(e.message))
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <p>Chargement…</p>;
  if (err) return <p style={{color:"#F66F57"}}>Erreur : {err}</p>;

  return (
    <div style={{maxWidth: 1100, margin: "30px auto", padding: "0 16px"}}>
      <h2 style={{color:"#01014B"}}>Praticiens</h2>
      <div style={{
        display:"grid",
        gridTemplateColumns:"repeat(auto-fit,minmax(260px,1fr))",
        gap: "18px"
      }}>
        {data.map(p => (
          <div key={p.id_praticien} style={{
            background:"#fff",
            borderRadius:16,
            boxShadow:"0 6px 22px rgba(0,0,0,.06)",
            padding:16
          }}>
            <div style={{display:"flex",alignItems:"center",gap:12}}>
              <img
                src={p.photo_profil_url || "https://via.placeholder.com/72"}
                alt=""
                width="72" height="72"
                style={{borderRadius:"50%",objectFit:"cover",border:"3px solid #FFD0B3"}}
              />
              <div>
                <div style={{fontWeight:800,color:"#01014B"}}>
                  {(p.nom || "").toUpperCase()} {(p.prenom || "").toUpperCase()}
                </div>
                <div style={{fontSize:13,color:"#2F3239"}}>{p.specialites}</div>
              </div>
            </div>
            <div style={{marginTop:10,fontSize:14,color:"#395441"}}>
              {p.adresse_cabinet}
            </div>
            <div style={{marginTop:6,fontWeight:700,color:"#F66F57"}}>
              À partir de {p.tarifs_consultation ?? "—"} €
            </div>
            <div style={{marginTop:6,color:"#FFC21A",fontWeight:700}}>
              ★ {p.taux_satisfaction ?? "—"} / 5
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
