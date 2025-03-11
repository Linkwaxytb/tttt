# Créer une interface PowerShell avec un design personnalisé
Add-Type -TypeDefinition @"
using System;
using System.Windows.Forms;
public class CustomPrompt : Form {
    private TextBox outputTextBox;
    private TextBox inputTextBox;
    public CustomPrompt() {
        this.outputTextBox = new TextBox() { Multiline = true, ScrollBars = ScrollBars.Vertical, Dock = DockStyle.Top, Height = 400, ReadOnly = true, BackColor = System.Drawing.Color.Black, ForeColor = System.Drawing.Color.White, Font = new System.Drawing.Font("Consolas", 10) };
        this.inputTextBox = new TextBox() { Dock = DockStyle.Bottom, BackColor = System.Drawing.Color.Black, ForeColor = System.Drawing.Color.White, Font = new System.Drawing.Font("Consolas", 10) };
        this.inputTextBox.KeyPress += new KeyPressEventHandler((sender, e) => { if (e.KeyChar -eq [char]13) { ExecuteCommand(this.inputTextBox.Text); } });
        this.Controls.Add(this.outputTextBox);
        this.Controls.Add(this.inputTextBox);
    }

    private void ExecuteCommand(string command) {
        this.outputTextBox.AppendText("C:\\> " + command + "`r`n");
        try {
            $output = cmd /c $command
            this.outputTextBox.AppendText($output + "`r`n")
        } catch {
            this.outputTextBox.AppendText("Erreur : " + $_.Exception.Message + "`r`n")
        }
        this.inputTextBox.Clear();
    }
}

[System.Windows.Forms.Application]::EnableVisualStyles()
$prompt = New-Object CustomPrompt
$prompt.ShowDialog()
"@
