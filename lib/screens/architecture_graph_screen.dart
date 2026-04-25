import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArchitectureGraphScreen extends StatefulWidget {
  const ArchitectureGraphScreen({super.key});

  @override
  State<ArchitectureGraphScreen> createState() => _ArchitectureGraphScreenState();
}

class _ArchitectureGraphScreenState extends State<ArchitectureGraphScreen> {
  late final WebViewController _controller;

  final String _htmlContent = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Skill Swap Platform - Animated Architecture Graph</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #0f172a;
            color: white;
            font-family: 'Inter', sans-serif;
            overflow: hidden;
        }
        #mynetwork {
            width: 100vw;
            height: 100vh;
        }
        #title {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 10;
            background: rgba(15, 23, 42, 0.8);
            padding: 15px 25px;
            border-radius: 12px;
            border: 1px solid #334155;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
        }
        h1 {
            margin: 0 0 10px 0;
            font-size: 24px;
            color: #3b82f6;
        }
        p {
            margin: 0;
            color: #94a3b8;
            font-size: 14px;
        }
    </style>
    <!-- Load vis-network -->
    <script type="text/javascript" src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>
</head>
<body>
    <div id="title">
        <h1>Skill Swap Architecture</h1>
        <p>Interactive & Animated Graph</p>
    </div>
    <div id="mynetwork"></div>

    <script type="text/javascript">
        var nodes = new vis.DataSet([
            { id: 1, label: "Client Browser", group: "client", shape: "icon", icon: { face: "'FontAwesome'", code: "\\uf0ac", size: 50, color: "#60a5fa" } },
            { id: 2, label: "Web Server\\n(Apache/Nginx)", group: "server", shape: "box", color: { background: "#1e293b", border: "#3b82f6" }, font: { color: "white" } },
            { id: 3, label: "PHP Application\\nLogic", group: "backend", shape: "circle", color: { background: "#3b82f6", border: "#2563eb" }, font: { color: "white" } },
            { id: 4, label: "MySQL Database", group: "database", shape: "database", color: { background: "#f59e0b", border: "#d97706" }, font: { color: "white" } },
            { id: 5, label: "Auth Module\\n(register/login)", group: "module", shape: "box", color: { background: "#475569", border: "#64748b" }, font: { color: "white" } },
            { id: 6, label: "Admin Dashboard", group: "module", shape: "box", color: { background: "#475569", border: "#64748b" }, font: { color: "white" } },
            { id: 7, label: "Student Dashboard", group: "module", shape: "box", color: { background: "#475569", border: "#64748b" }, font: { color: "white" } },
            { id: 8, label: "Skill Matching\\nLogic", group: "module", shape: "box", color: { background: "#8b5cf6", border: "#7c3aed" }, font: { color: "white" } },
            { id: 9, label: "Payment & Setup\\n(JazzCash, EasyPaisa)", group: "module", shape: "box", color: { background: "#10b981", border: "#059669" }, font: { color: "white" } },
            { id: 10, label: "index.php", group: "file", shape: "ellipse", color: { background: "#334155", border: "#475569" }, font: { color: "#cbd5e1", size: 12 } },
            { id: 11, label: "database.sql", group: "file", shape: "ellipse", color: { background: "#334155", border: "#475569" }, font: { color: "#cbd5e1", size: 12 } },
            { id: 12, label: "seed_skills.php", group: "file", shape: "ellipse", color: { background: "#334155", border: "#475569" }, font: { color: "#cbd5e1", size: 12 } },
        ]);

        var edges = new vis.DataSet([
            { from: 1, to: 2, label: "HTTP/HTTPS", arrows: "to, from", color: { color: "#94a3b8" }, length: 200, smooth: { type: "curvedCW" } },
            { from: 2, to: 3, label: "Processes", arrows: "to, from", color: { color: "#94a3b8" }, length: 150 },
            { from: 3, to: 4, label: "PDO Query", arrows: "to, from", color: { color: "#94a3b8" }, length: 200 },
            { from: 3, to: 5, arrows: "to", color: { color: "#475569" } },
            { from: 3, to: 6, arrows: "to", color: { color: "#475569" } },
            { from: 3, to: 7, arrows: "to", color: { color: "#475569" } },
            { from: 3, to: 8, arrows: "to", color: { color: "#475569" } },
            { from: 3, to: 9, arrows: "to", color: { color: "#475569" } },
            { from: 5, to: 6, label: "Redirect", arrows: "to", color: { color: "#64748b", opacity: 0.5 }, dashes: true },
            { from: 5, to: 7, label: "Redirect", arrows: "to", color: { color: "#64748b", opacity: 0.5 }, dashes: true },
            { from: 7, to: 8, label: "Triggers", arrows: "to", color: { color: "#8b5cf6" }, length: 100 },
            { from: 10, to: 1, label: "Serves", arrows: "to", color: { color: "#334155" }, dashes: true },
            { from: 11, to: 4, label: "Schema", arrows: "to", color: { color: "#334155" }, dashes: true },
            { from: 12, to: 4, label: "Inserts", arrows: "to", color: { color: "#334155" }, dashes: true }
        ]);

        var container = document.getElementById('mynetwork');
        var data = { nodes: nodes, edges: edges };
        var options = {
            nodes: { borderWidth: 2, shadow: true, font: { face: 'Inter, sans-serif' } },
            edges: { width: 2, shadow: true, smooth: { type: 'continuous' } },
            physics: {
                forceAtlas2Based: { gravitationalConstant: -100, centralGravity: 0.01, springLength: 200, springConstant: 0.08 },
                maxVelocity: 50, solver: 'forceAtlas2Based', timestep: 0.35, stabilization: { iterations: 150 }
            },
            interaction: { hover: true, tooltipDelay: 200, zoomView: true }
        };
        var network = new vis.Network(container, data, options);
        
        network.once("beforeDrawing", function() {
            network.focus(3, { scale: 1.2, animation: { duration: 1500, easingFunction: "easeInOutQuad" } });
        });
        
        network.on("click", function(params) {
            if (params.nodes.length > 0) {
                var nodeId = params.nodes[0];
                var nodePosition = network.getPositions([nodeId])[nodeId];
                network.moveNode(nodeId, nodePosition.x + (Math.random() * 40 - 20), nodePosition.y + (Math.random() * 40 - 20));
            }
        });
    </script>
</body>
</html>
''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(_htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Architecture Graph'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
